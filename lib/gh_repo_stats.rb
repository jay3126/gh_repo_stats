require "thor"

ROOT_DIR = File.dirname(__FILE__)

require File.join(ROOT_DIR, "gh_repo_stats/version")
require File.join(ROOT_DIR, "gh_repo_stats/query")

module GhRepoStats
  class CLI < Thor
    default_task :fetch

    desc "[--after DATETIME] [--before DATETIME] [--event EVENT_NAME] [-count COUNT]", "Fetch the most active repositories for a given event & time range on GitHub"
    option :after, banner: "Show activity from this DATETIME", required: true
    option :before, banner: "Show activity to this DATETIME", required: true
    option :event, banner: "Filter by EVENT_NAME", required: true
    option :count, banner: "Limit the number of results to this COUNT (default 10)", default: 10, type: :numeric

    def fetch
      grs = GhRepoStats::Query.new(options)
      grs.execute
      puts grs.to_s
    end

  end
end