require_relative '../lib/sssaas-ruby.rb'
require 'test/unit'

class TestSSSaaS < Test::Unit::TestCase
    def test_from_yaml()
        secret = SSSaaS::API.from_yaml("database_password:\n    remote: ['http://localhost:8765/api/v0/request/test?key=sssaas-library-test-allowed']\n    local: ./tests/secrets.sssa\n    minimum: 4\n", "database_password")

        assert(secret == "test-pass", "Error with API testing...")
    end

    def test_from_config()
        obj = {"remote"=>["http://localhost:8765/api/v0/request/test?key=sssaas-library-test-allowed"], "shares"=>["j8-Y4_7CJvL8aHxc8WMMhP_K2TEsOkxIHb7hBcwIBOo=T5-EOvAlzGMogdPawv3oK88rrygYFza3KSki2q8WEgs=", "wGXxa_7FPFSVqdo26VKdgFxqVVWXNfwSDQyFmCh2e5w=8bTrIEs0e5FeiaXcIBaGwtGFxeyNtCG4R883tS3MsZ0="], "minimum"=>4}



        secret = SSSaaS::API.from_config(obj)

        assert(secret == "test-pass", "Error with API testing...")
    end

    def test_create_combine()
        api = "http://localhost:8765/api/v0/request/test?key=sssaas-library-test-allowed"
        shares = ["j8-Y4_7CJvL8aHxc8WMMhP_K2TEsOkxIHb7hBcwIBOo=T5-EOvAlzGMogdPawv3oK88rrygYFza3KSki2q8WEgs=", "wGXxa_7FPFSVqdo26VKdgFxqVVWXNfwSDQyFmCh2e5w=8bTrIEs0e5FeiaXcIBaGwtGFxeyNtCG4R883tS3MsZ0="]
        minimum = 4
        secret = SSSaaS::API.get_secret(api, shares, minimum)
        assert(secret == "test-pass", "Error with API testing...")
    end
end
