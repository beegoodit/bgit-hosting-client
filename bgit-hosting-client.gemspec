$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require_relative "lib/bgit/hosting/client/version"

Gem::Specification.new do |spec|
  spec.name = "bgit-hosting-client"
  spec.version = Bgit::Hosting::Client::VERSION
  spec.authors = ["BeeGood IT"]
  spec.email = ["info@beegoodit.de"]
  spec.summary = "A gem for posting Docker stats to an API endpoint."
  spec.description = "This gem provides a simple way to post Docker stats to an API endpoint using HTTParty."
  spec.homepage = "https://bitbucket.org/beegoodit/bgit-hosting-client"
  spec.license = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]
  end
  spec.executables = ["bgit-hosting-client"]
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
