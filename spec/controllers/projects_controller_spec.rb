# encoding: utf-8

require 'spec_helper'

describe ProjectsController do
  let(:user) { create_user! }
  let(:project) { Factory(:project) }

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    it "displays an error message when asked for a missing project" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      flash[:error].should eql(I18n.t("projects.not_found_msg"))
    end

    context "standard users" do
      { :new => "get", :create => "post", :edit => "get",
        :update => "put", :destroy => "delete" }.each_pair do |action, method|
        it "cannot access the #{action} action" do
          sign_in(:user, user)
          send(method, action, :id => project.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql( I18n.t("authenticate.must_admin_msg") )
        end
      end
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    it "找不到專案時顯示錯誤信息" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      flash[:error].should eql(I18n.t("projects.not_found_msg"))
    end

    context "一般帳戶" do
      { :new => "get", :create => "post", :edit => "get",
        :update => "put", :destroy => "delete" }.each_pair do |action, method|
        it "是不可以執行 \"#{action}\" 工作" do
          sign_in(:user, user)
          send(method, action, :id => project.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql( I18n.t("authenticate.must_admin_msg") )
        end
      end
    end
  end
end
