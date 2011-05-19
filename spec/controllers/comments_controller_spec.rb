# encoding: utf-8

require 'spec_helper'

describe CommentsController do

  let(:project) { Project.create!(:name => "Ticketee") }

  let(:state) { State.create!(:name => "New") }
  let(:user) { create_user! }

  let(:ticket) do
    project.tickets.create(:title => "State transitions",
                           :description => "Can't be hacked.",
                           :user => user)
  end

  describe "language is English" do
    before(:each) do
      I18n.locale = "en"
      I18n.default_locale = "en"
    end

    context "a user without permission to set state" do
      before do
        sign_in(:user, user)
      end

      it "cannot transition a state by passing through state_id" do
        post :create, { :comment => { :text => "Hacked!", :state_id => state.id },
                        :ticket_id => ticket.id, :tags => ""}
        ticket.reload
        ticket.state.should eql(nil)
      end

      it "cannot tag a ticket without permission" do
        post :create, { :tags => "one two", :comment => { :text => "Tag!" },
                        :ticket_id => ticket.id }
        ticket.reload
        ticket.tags.should be_empty
      end
    end
  end


  describe "選擇語言為中文(zh-HK)" do
    before(:each) do
      I18n.locale = "zh-HK"
      I18n.default_locale = "zh-HK"
    end

    context "用戶未有更新工作單狀態權限" do
      before do
        sign_in(:user, user)
      end

      it "不能因加入回應而改變工作單狀態" do
        post :create, { :comment => { :text => "Hacked!", :state_id => state.id },
                        :ticket_id => ticket.id, :tags => "" }
        ticket.reload
        ticket.state.should eql(nil)
      end

      it "不能給工作單加入標籤" do
        post :create, { :tags => "one two", :comment => { :text => "Tag!" },
                        :ticket_id => ticket.id }
        ticket.reload
        ticket.tags.should be_empty
      end
    end
  end
end
