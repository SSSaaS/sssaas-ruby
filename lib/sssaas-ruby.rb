require 'sssa'
require 'net/http'
require 'uri'
require 'json'

module SSSaaS
    module API
        def self.get_secret(serveruris, tokens, secrets, timeout=300)
            results = secrets

            unless serveruris.class == [].class
                serveruris = [serveruris]
            end

            unless tokens.class == [].class
                tokens = [tokens]
            end

            threads = []

            serveruris.each_with_index do |serveruri, index|
                threads.push(Thread.new do
                    uri = URI.parse(serveruri + '?key=' + tokens[index])

                    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                        http.read_timeout = timeout
                        request = Net::HTTP::Get.new uri
                        request.add_field('User-Agent', 'sssaas-ruby v0 v0.0.2')
                        response = http.request request
                        unless response.kind_of? Net::HTTPSuccess
                            raise response.class.to_s + ': ' + response.message
                        else
                            (JSON.parse(response.body)['sharedSecrets']).each {|s|
                                s.strip!
                                results.push s
                            }
                        end
                    end
                end)
            end

            threads.each { |t|  t.join }

            results = results.uniq

            return SSSA::combine(results)
        end
    end
end
