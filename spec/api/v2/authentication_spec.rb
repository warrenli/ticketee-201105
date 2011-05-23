require "spec_helper"

describe "API errors", :type => :api do
  let(:token) { "" }

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    it "making a request with no token" do
      get "/api/v2/projects.json", :token => token
      error = { :error => "Token is invalid." }
      last_response.body.should eql(error.to_json)
    end
  end
end
