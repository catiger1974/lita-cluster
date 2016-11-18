require 'httpclient'
require 'json'

module Lita
  module Extensions
    class Ha
      @hipchat_token = ''
      @hipchat_endpoint = ''
      @hipchat_user = ''
      @http_client = HTTPClient.new

      def self.formalize_line(line)
        line.split('=>')[1].gsub("'", "").gsub('"', '').gsub(',','').strip
      end

      def self.init_cfg(cfg_file)
        File.readlines(cfg_file).each do |line|

          next if line.strip[0] == '#' ## Filter out commented line

          if line.include?('hipchat_token')
            value = formalize_line(line)
            @hipchat_token = value
          elsif line.include?('hipchat_endpoint')
            value = formalize_line(line)
            @hipchat_endpoint = value
          elsif line.include?('hipchat_user')
            value = formalize_line(line)
            @hipchat_user = value
          end
        end
      end

      def self.online?()
        begin
          uri = "#{@hipchat_endpoint}/v2/user/#{@hipchat_user}?auth_token=#{@hipchat_token}"
          resp = @http_client.get_content(uri)
          msg = JSON.parse(resp)
          ret = false
          if msg.has_key?('presence') and (not msg['presence'].nil?)
            if msg['presence'].has_key?('is_online') and msg['presence']['is_online'] == true
              ret = true
            end
          end
        rescue SocketError, JSON::UnparserError, HTTPClient::BadResponseError => e
          puts("Error : #{e.message}")
        ensure
          return ret
        end
      end

      def self.call(payload)
        init_cfg(payload[:config_path])

        puts("HA extension started ... ")
        while online? do
          puts("The other BOT is up, I am standby ... ")
          sleep(2)
        end
        puts("The other node was down, I start serving now ... ")

      end
      # If your extension needs to register with a Lita hook, uncomment the
      # following line and change the hook name to the appropriate value:
      Lita.register_hook(:config_finalized, self)
    end
  end
end
