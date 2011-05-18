# encoding: utf-8

require 'spec_helper'

def cannot_create_tickets!
  response.should redirect_to(project)
  flash[:alert].should eql( I18n.t("tickets.not_authorized_to_create_msg") )
end

def cannot_update_tickets!
  response.should redirect_to(project)
  flash[:alert].should eql(I18n.t("tickets.not_authorized_to_update_msg"))
end

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

    context "with permission to view the project" do
      before do
        sign_in(:user, user)
        Permission.create(:user => user, :permissible => project, :action => "view")
      end

      it "cannot begin to create a ticket" do
        get :new, :project_id => project.id
        cannot_create_tickets!
      end

      it "cannot create a ticket without permission" do
        post :create, :project_id => project.id
        cannot_create_tickets!
      end

      it "cannot edit a ticket without permission" do
        get :edit, { :project_id => project.id, :id => ticket.id }
        cannot_update_tickets!
      end

      it "cannot update a ticket without permission" do
        put :update, { :project_id => project.id, :id => ticket.id }
        cannot_update_tickets!
      end

      it "cannot delete a ticket without permission" do
        delete :destroy, { :project_id => project.id, :id => ticket.id }
        response.should redirect_to(project)
        flash[:alert].should eql(I18n.t("tickets.not_authorized_to_delete_msg"))
      end

      it "can create tickets, but not tag them" do
        Permission.create(:user => user, :permissible => project, :action => "create tickets")
        post :create, :ticket => { :title => "New ticket!",
                                   :description => "Brand spankin' new" },
                      :project_id => project.id,
                      :tags => "these are tags"
        Ticket.last.tags.should be_empty
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

    context "帳戶有閱讀專案的權限" do
      before do
        sign_in(:user, user)
        Permission.create(:user => user, :permissible => project, :action => "view")
      end

      it "不可以嘗試建立專案的工作單" do
        get :new, :project_id => project.id
        cannot_create_tickets!
      end

      it "沒有工作單建立權限是不能執行這個工作" do
        post :create, :project_id => project.id
        cannot_create_tickets!
      end

      it "不可以嘗試修改專案的工作單" do
        get :edit, { :project_id => project.id, :id => ticket.id }
        cannot_update_tickets!
      end

      it "沒有工作單修改權限是不能執行這個工作" do
        put :update, { :project_id => project.id, :id => ticket.id }
        cannot_update_tickets!
      end

      it "沒有工作單刪除權限是不能執行這個工作" do
        delete :destroy, { :project_id => project.id, :id => ticket.id }
        response.should redirect_to(project)
        flash[:alert].should eql(I18n.t("tickets.not_authorized_to_delete_msg"))
      end

      it "有工作單建立權限仍不可以給工作單加入標籤" do
        Permission.create(:user => user, :permissible => project, :action => "create tickets")
        post :create, :ticket => { :title => "新工作單",
                                   :description => "測試工作單的標籤功動" },
                      :project_id => project.id,
                      :tags => "測試 工作單 標籤"
        Ticket.last.tags.should be_empty
      end
    end
  end
end
