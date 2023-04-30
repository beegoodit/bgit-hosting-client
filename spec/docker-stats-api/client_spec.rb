require "spec_helper"
require "docker-stats-api"

RSpec.describe DockerStatsApi::Client, vcr: true do
  describe "#post_stats" do
    it "posts stats to the API endpoint" do
      endpoint = "http://localhost:3000/api/hosting/create_docker_resource_usage_services.json"
      client = DockerStatsApi::Client.new(endpoint, "localhost")

      response = client.post_stats

      expect(response.code).to eq(200)
    end
  end
end
