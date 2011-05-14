# encoding: utf-8

require 'spec_helper'

describe TicketsController do
  let(:user) { create_user! }
  let(:project) { Factory(:project) }
  let(:ticket) { Factory(:ticket, :project => project) }

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "standard users" do
      it "cannot access a ticket for a project" do
        sign_in(:user, user)
        get :show, :id => ticket.id, :project_id => project.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("projects.not_found_msg"))
      end
    end
  end

  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    context "一般帳戶" do
      it "是不可以處理專案的工作單" do
        sign_in(:user, user)
        get :show, :id => ticket.id, :project_id => project.id
        response.should redirect_to(root_path)
        flash[:alert].should eql(I18n.t("projects.not_found_msg"))
      end
    end
  end
end
