Gem::Specification.new do |s|
    s.name        = 'sssaas-ruby'
    s.version     = '0.0.2'
    s.date        = '2015-11-07'
    s.summary     = "Shamir's Secret Sharing as a Service - Ruby Module"
    s.description = "API library for SSSaaS in Ruby"
    s.authors     = ["Alexander Scheel"]
    s.email       = 'alexander.m.scheel@gmail.com'
    s.files       = ["lib/sssaas-ruby.rb"]
    s.homepage    = 'https://git.cipherboy.com:8443/SSSAAS/sssaas-ruby'
    s.license     = 'MIT'
    s.add_runtime_dependency 'sssa-ruby', '~> 0.0.2', '= 0.0.2'
end
