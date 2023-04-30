require "vcr"
require "webmock"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.around(:each, vcr: true) do |example|
    name = example.metadata[:full_description]
      .split(/\s+/, 2)
      .join("/")
      .gsub(/[^\w\/]+/, "_")
      .gsub(/\//, "__")
    VCR.use_cassette(name, &example)
  end
end
