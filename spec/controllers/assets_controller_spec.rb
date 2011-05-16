# encoding: utf-8

require 'spec_helper'

describe AssetsController do
  let(:project)   { Factory(:project) }
  let(:ticket)    { Factory(:ticket, :project => project) }
  let(:good_user) { create_user! }
  let(:bad_user)  { create_user! }
  let(:path)      { Rails.root + "spec/fixtures/speed.txt" }
  let(:asset)     { ticket.assets.create(:asset => File.open(path)) }

  before do
    good_user.permissions.create!(:action => "view", :permissible => project)
  end

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "users with access" do
      before do
        sign_in(:user, good_user)
      end

      it "can access assets in a project" do
        get 'show', :id => asset.id
        response.body.should eql(File.read(path))
      end
    end

    context "users without access" do
      before do
        sign_in(:user, bad_user)
      end

      it "cannot access assets in this project" do
        get 'show', :id => asset.id
        response.should redirect_to(root_path)
        flash[:alert].should eql("The asset you were looking for could not be found.")
      end
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

  end
end
