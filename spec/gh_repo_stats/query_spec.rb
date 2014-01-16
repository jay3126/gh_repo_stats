require "spec_helper"

module GhRepoStats
  describe Query do

    let(:grs) { GhRepoStats::Query.new({after: "2012-11-01T13:00:00Z", before: "2012-11-01T23:00:00Z", event: "PushEvent", count: 12}) }

    describe '#initialize' do
      it 'creates an events Array' do
        expect(grs.events).to be_a(Array)
      end

      it 'creates a repos Array' do
        expect(grs.repos).to be_a(Array)
      end

      it 'parses after value to DateTime' do
        expect(grs.after).to be_a(DateTime)
      end

      it 'parses before value to DateTime' do
        expect(grs.after).to be_a(DateTime)
      end

      it 'has the correct count value' do
        expect(grs.count).to eql 12
      end

      it 'has the correct event_type value' do
        expect(grs.event_type).to eql "PushEvent"
      end
    end

    describe '#execute' do
      before do
        VCR.use_cassette "grs/sample" do
          grs.execute
        end
      end

      it 'should populate events Array' do
        expect(grs.events.count).to be > 0
      end

      it 'should populate repos Array' do
        expect(grs.repos.count).to be > 0
      end
    end

    describe '#to_s' do
      before do
        VCR.use_cassette "grs/sample" do
          grs.execute
        end
      end

      it 'matches with the number of items in the repos array' do
        expect(grs.to_s.lines.count).to eql grs.repos.count
      end
    end
  end
end