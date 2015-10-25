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
                response = http.request request
                if request[0] != '{'
                    return request
                else
                    return SSSA::Combine(JSON.parse(request)['sharedSecrets'] + secrets)
                end
            end
        end
    end
end
