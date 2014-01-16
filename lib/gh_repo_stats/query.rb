require 'open-uri'
require 'zlib'
require 'yajl'
require 'ruby-progressbar'

module GhRepoStats
  class Query
    attr_accessor :after, :before, :event_type, :count
    attr_reader :events, :repos, :progress

    def initialize(options={})
      @events = []
      @repos = []

      @after  = DateTime.parse(options[:after])
      @before = DateTime.parse(options[:before])

      @event_type  = options[:event]
      @count  = options[:count]
    end

    def execute
      threads = []

      @after.step(@before, 1.0/24) do |date|
        threads << Thread.new do
          filename = date.strftime("%Y-%m-%d-%k").gsub(/\s+/, "")
          url = "http://data.githubarchive.org/#{filename}.json.gz"
          parse(url)
        end
      end

      @progress = ProgressBar.create(title: "Fetching Data:", total: threads.count, format: '%t |%b>>%i| %p% Complete')

      threads.each { |thread|  thread.join }

      aggregate
    end

    def to_s
      output = []
      @repos.each do |slug, events|
        output << "#{slug} - #{events.length} events"
      end
      output.join("\n")
    end

    private

    def parse(url)
      js = Zlib::GzipReader.new(open(url)).read

      Yajl::Parser.parse(js) do |event|
        event['slug'] = event['repository'].nil? ? event['url'] : "#{event['repository']['owner']}/#{event['repository']['name']}"
        @events << event if event_date_within_range?(DateTime.parse(event['created_at'])) && event_type_match?(event['type'])
      end

      @progress.increment
    end

    def aggregate
      @repos = @events.group_by { |event| event['slug'] }.sort_by { |slug, events| events.length }.reverse.slice(0..(@count.to_i - 1))
    end

    def event_date_within_range?(event_date)
      event_date > @after && event_date < @before
    end

    def event_type_match?(event_type)
      @event_type == event_type
    end

  end
end
