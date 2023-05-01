module Bgit
  module Hosting
    module Client
      class Stats
        def initialize(endpoint, host, api_token)
          @endpoint = endpoint
          @host = host
          @api_token = api_token
        end

        def perform
          @raw_stats = raw_stats
          @parsed_stats = parsed_stats
          @mapped_stats = mapped_stats

          send_stats
        end

        def execute_docker_stats_command
          `docker stats --no-stream --format '{{json .}}'`
        end

        def raw_stats
          @raw_stats ||= execute_docker_stats_command
        end

        def parsed_stats
          @parsed_stats ||= @raw_stats.split("\n").collect { |rs| JSON.parse(rs) }
        end

        def request_bodies
          @request_bodies ||= @mapped_stats.collect { |ms| {create_docker_resource_usage_service: ms} }
        end

        def request_headers
          @request_headers ||= {
            "Content-Type" => "application/json",
            "Accept" => "application/json",
            "Authorization" => "Bearer #{@api_token}"
          }
        end

        def send_stats
          request_bodies.collect do |request_body|
            HTTParty.post(@endpoint,
              headers: request_headers,
              body: request_body.to_json)
          end
        end

        def mapped_stats
          @mapped_stats ||= @parsed_stats.map do |parsed_stats|
            {
              fqdn: @host,
              container_identifier: parsed_stats["ID"],
              container_name: parsed_stats["Name"],
              stats_identifier: parsed_stats["ID"],
              pids: parsed_stats["PIDs"],
              cpu_percentage: self.class.toPercentage(parsed_stats["CPUPerc"]),
              mem_percentage: self.class.toPercentage(parsed_stats["MemPerc"]),
              mem_usage_bytes: self.class.toBytes(parsed_stats["MemUsage"].split(" / ")[0]),
              mem_limit_bytes: self.class.toBytes(parsed_stats["MemUsage"].split(" / ")[1]),
              block_io_tx_bytes: self.class.toBytes(parsed_stats["BlockIO"].split(" / ")[0]),
              block_io_rx_bytes: self.class.toBytes(parsed_stats["BlockIO"].split(" / ")[1]),
              net_io_tx_bytes: self.class.toBytes(parsed_stats["NetIO"].split(" / ")[0]),
              net_io_rx_bytes: self.class.toBytes(parsed_stats["NetIO"].split(" / ")[1])
            }
          end
        end

        def self.toPercentage(value)
          value.delete("%").to_f
        end

        def self.toBytes(value)
          result = if value.end_with?("GiB")
            value.gsub("GiB", "").to_f * 1024 * 1024 * 1024
          elsif value.end_with?("MiB")
            value.gsub("MiB", "").to_f * 1024 * 1024
          elsif value.end_with?("kB")
            value.gsub("kB", "").to_f * 1024
          elsif value.end_with?("B")
            value.delete("B").to_f
          else
            value
          end
          result.to_i
        end
      end
    end
  end
end
