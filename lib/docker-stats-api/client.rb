module DockerStatsApi
  class Client
    def initialize(endpoint, host)
      @endpoint = endpoint
      @host = host
    end

    def post_stats
      stats = `docker stats --no-stream --format '{{json .}}'`
      request_params = {create_docker_resource_usage_service: map_stats(stats)}
      response = HTTParty.post(@endpoint,
        headers: {"Content-Type" => "application/json"},
        params: request_params)

      response.code
    end

    def map_stats(stats)
      parsed_stats = JSON.parse(stats)
      {
        fqdn: @host,
        container_identifier: parsed_stats["ID"],
        container_name: parsed_stats["Name"],
        stats_identifier: parsed_stats["ID"],
        pids: parsed_stats["PIDs"],
        cpu_percentage: parsed_stats["CPUPerc"].delete("%").to_f,
        mem_percentage: parsed_stats["MemPerc"].delete("%").to_f,
        mem_usage_bytes: toBytes(parsed_stats["MemUsage"].split(" / ")[0]),
        block_io_tx_bytes: toBytes(parsed_stats["BlockIO"].split(" / ")[0]),
        block_io_rx_bytes: toBytes(parsed_stats["BlockIO"].split(" / ")[1]),
        net_io_tx_bytes: toBytes(parsed_stats["NetIO"].split(" / ")[0]),
        net_io_rx_bytes: toBytes(parsed_stats["NetIO"].split(" / ")[1])
      }
    end

    def toBytes(value)
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
