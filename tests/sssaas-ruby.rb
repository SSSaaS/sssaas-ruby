require_relative '../lib/sssaas-ruby.rb'
require 'test/unit'

class TestSSSaaS < Test::Unit::TestCase
    def test_api()
        assert(SSSaaS::API.get_secret(["https://sssaas.cipherboy.com:8444/api/v0/request/test"], ["sssaas-library-test-allowed"], ["j8-Y4_7CJvL8aHxc8WMMhP_K2TEsOkxIHb7hBcwIBOo=T5-EOvAlzGMogdPawv3oK88rrygYFza3KSki2q8WEgs=", "wGXxa_7FPFSVqdo26VKdgFxqVVWXNfwSDQyFmCh2e5w=8bTrIEs0e5FeiaXcIBaGwtGFxeyNtCG4R883tS3MsZ0="]) == "test-pass", "Error with API testing...")
    end
end
