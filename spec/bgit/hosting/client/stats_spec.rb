require "spec_helper"
require "bgit-hosting-client"

RSpec.describe Bgit::Hosting::Client::Stats, vcr: true do
  let(:endpoint) { "http://localhost:3000/api/hosting/create_docker_resource_usage_services.json" }
  let(:host) { "localhost" }
  let(:api_token) { "ae100b06f4353392dfc8c5a1b6d58dc68f092caf3b34a3adfe46d4098fe27f75" }
  let(:stats) {
    "{\"BlockIO\":\"0B / 0B\",\"CPUPerc\":\"0.00%\",\"Container\":\"78f21cfdaa7d\",\"ID\":\"78f21cfdaa7d\",\"MemPerc\":\"0.00%\",\"MemUsage\":\"960KiB / 31.31GiB\",\"Name\":\"zealous_saha\",\"NetIO\":\"1.01kB / 0B\",\"PIDs\":\"1\"}\n{\"BlockIO\":\"0B / 0B\",\"CPUPerc\":\"0.00%\",\"Container\":\"6601ead6fe89\",\"ID\":\"6601ead6fe89\",\"MemPerc\":\"0.00%\",\"MemUsage\":\"960KiB / 31.31GiB\",\"Name\":\"happy_swirles\",\"NetIO\":\"1.23kB / 0B\",\"PIDs\":\"1\"}\n"
  }

  describe "#post_stats" do
    it "posts stats to the API endpoint" do
      expect_any_instance_of(Bgit::Hosting::Client::Stats).to receive(:execute_docker_stats_command).and_return(stats)

      client = Bgit::Hosting::Client::Stats.new(endpoint, host, api_token)

      results = client.perform

      expect(results.map(&:code)).to eq([201, 201])
    end
  end
end
