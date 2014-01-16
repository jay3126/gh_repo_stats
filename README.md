# GhRepoStats

Fetches most active repositories for a given event & time range on GitHub utilizing the GitHub Archive project.

## Installation

    git clone git@github.com:jesalg/gh_repo_stats.git
    cd gh_repo_stats
    rake install

## Usage

Command Line

    gh_repo_stats [--after DATETIME] [--before DATETIME] [--event EVENT_NAME] [--count COUNT]

Usage Example

    $ gh_repo_stats --after 2012-11-01T13:00:00Z --before 2012-11-02T03:12:14-03:00 --event PushEvent

Sample Output

	sakai-mirror/melete - 168 events
	runningforworldpeace/feeds - 103 events
	chapuni/llvm-project-submodule - 98 events
	chapuni/llvm-project - 98 events
	Frameset91/untitled0815 - 94 events
	josmera01/juanrueda-internation - 78 events
	artmig/artmig.github.com - 76 events
	mozilla/mozilla-central - 69 events
	bcomdlc/bcom-homepage-archive - 68 events
	sakai-mirror/ambrosia - 68 events

## Tests

Run this to execute the test suite

   rspec spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
