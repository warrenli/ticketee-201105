require "spec_helper"

describe "/api/v1/projects", :type => :api do
  let(:user) do 
    user = create_user!
    user.update_attribute(:admin, true)
    user
  end
  
  let(:token) { user.authentication_token }
  let(:project) { Factory(:project, :name => "Inspector") }

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "projects viewable by this user" do
      before do
        user.permissions.create!(:action => "view", :permissible => project)
        Factory(:project, :name => "Access denied.")
      end

      let(:url) { "/api/v1/projects" }
      context "index" do
        it "JSON" do
          get "#{url}.json", :token => token
          projects_json = Project.readable_by(user).to_json
          last_response.body.should eql(projects_json)
          last_response.status.should eql(200)
          projects = JSON.parse(last_response.body)
          projects.any? do |p|
            p["project"]["name"] == "Inspector"
          end.should be_true
        end
      end
    end
  end
end
