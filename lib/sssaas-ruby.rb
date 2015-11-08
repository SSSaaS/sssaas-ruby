require 'sssa'
require 'net/http'
require 'uri'
require 'json'

module SSSAAS
    module API
        def self.get_secret(serveruri, token, secrets, timeout=300)
            uri = URI.parse(serveruri + "?key=" + token)

            Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                http.read_timeout = timeout
                request = Net::HTTP::Get.new uri
                request.add_field('User-Agent', 'sssaas-ruby v0 v0.0.1')
                response = http.request request
                unless response.kind_of? Net::HTTPSuccess
                    raise response.class.to_s + ": " + response.message
                else
                    puts response.body.to_s
                    puts JSON.parse(response.body)
                    puts JSON.parse(response.body)["sharedSecrets"]
                    puts secrets
                    puts JSON.parse(response.body)["sharedSecrets"] + secrets
                    return SSSA::combine(JSON.parse(response.body.to_s)['sharedSecrets'] + secrets)
                end
            end
        end
    end
end
