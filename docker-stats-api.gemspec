$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require_relative "lib/docker-stats-api/version"

Gem::Specification.new do |spec|
  spec.name = "docker-stats-api"
  spec.version = DockerStatsApi::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["you@example.com"]
  spec.summary = "A gem for posting Docker stats to an API endpoint."
  spec.description = "This gem provides a simple way to post Docker stats to an API endpoint using HTTParty."
  spec.homepage = "https://github.com/yourusername/docker-stats-api"
  spec.license = "MIT"

  spec.files = ["lib/docker-stats-api.rb",
    "lib/docker-stats-api/client.rb",
    "lib/docker-stats-api/version.rb",
    "bin/docker-stats-api"]
  spec.executables = ["docker-stats-api"]
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-standardrb"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
