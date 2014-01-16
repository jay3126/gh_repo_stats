# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gh_repo_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "gh_repo_stats"
  spec.version       = GhRepoStats::VERSION
  spec.authors       = ["Jesal Gadhia"]
  spec.email         = ["jesal7@gmail.com"]
  spec.description   = %q{Gem to report GitHub repository stats}
  spec.summary       = %q{Fetches most active repositories for a given event & time range on GitHub utilizing the GitHub Archive project}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr", "~> 2.8.0"
  spec.add_development_dependency "webmock", "~> 1.16.1"

  spec.add_dependency "thor", "~> 0.18"
  spec.add_dependency "yajl-ruby", "~> 1.2.0"
  spec.add_dependency "ruby-progressbar", "~> 1.4.0"
end
