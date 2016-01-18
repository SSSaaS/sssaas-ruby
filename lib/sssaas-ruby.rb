require 'sssa'
require 'net/http'
require 'uri'
require 'json'
require 'yaml'

module SSSaaS
    module API
        def self.from_yaml(data, key)
            obj = YAML.load(data)

            return self.from_config(obj[key])
        end

        def self.from_config(obj)
            if obj.nil?
                return ""
            end

            if obj["remote"].nil?
                raise Exception.new("Invalid config object -- missing remote")
            end

            if obj["shares"].nil? and obj["local"].nil?
                raise Exception.new("Invalid config object -- missing shares or local")
            end

            if obj["minimum"].nil?
                raise Exception.new("Invalid config object -- missing minimum")
            end

            if obj["local"]
                if obj["shares"].nil?
                    obj["shares"] = []
                end

                File.open(obj["local"], "r") do |f|
                    f.each_line do |line|
                        line = line.chomp!
                        if SSSA::isValidShare? line
                            obj["shares"].push line
                        end
                    end
                end
            end

            return self.get_secret(obj["remote"], obj["shares"], obj["minimum"], obj["timeout"])
        end

        def self.get_secret(endpoints, shares, minimum, timeout=300)
            results = shares

            if endpoints.class == "string".class
                endpoints = [endpoints]
            elsif endpoints.class != [].class
                raise Exception.new("Invalid config object -- remote should be an array of URIs")
            end

            if shares.class == "string".class
                shares = [shares]
            elsif shares.class != [].class
                raise Exception.new("Invalid config object -- shares should be an array of shares")
            end

            unless minimum.class == 1234567890.class
                raise Exception.new("Invalid config object -- shares should be an array of shares")
            end

            tpool = []
            errors = []

            endpoints.each_with_index do |serveruri, index|
                tpool.push(Thread.new do
                    uri = URI.parse(serveruri)

                    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                        http.read_timeout = timeout
                        request = Net::HTTP::Get.new uri
                        request.add_field('User-Agent', 'sssaas-ruby v0 v0.0.2')
                        response = http.request request
                        unless response.kind_of? Net::HTTPSuccess
                            errors.push response.class.to_s + ': ' + response.message
                        else
                            (
                                JSON.parse(response.body)['sharedSecrets']
                            ).each { |s|
                                s.strip!
                                results.push s
                            }
                            results = results.uniq

                            if results.size > minimum
                                tpool.each { |t| t.kill }
                            end
                        end
                    end
                end)
            end

            tpool.each { |t|  t.join }

            results = results.uniq

            return SSSA::combine(results)
        end
    end
end
