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

        it "XML" do
          get "#{url}.xml", :token => token
          last_response.body.should eql(Project.readable_by(user).to_xml)
          projects = Nokogiri::XML(last_response.body)
          projects.css("project name").text.should eql("Inspector")
        end
      end
    end

    context "creating a project" do
      let(:url) { "/api/v1/projects" }

      it "sucessful JSON" do
        post "#{url}.json", :token => token,
                            :project => {
                              :name => "Ticketee"
                            }
        project = Project.find_by_name("Ticketee")
        last_response.status.should eql(201)
        last_response.body.should eql(project.to_json)
      end

      it "unsuccessful JSON" do
        post "#{url}.json", :token => token,
                            :project => {}
        last_response.status.should eql(422)
        errors = { "name" => ["can't be blank"] }
        last_response.body.should eql(errors.to_json)
      end
    end
  end
end
