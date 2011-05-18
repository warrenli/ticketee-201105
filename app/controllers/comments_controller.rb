class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_ticket

  def create
    if cannot?(:"change states", @ticket.project) && !current_user.admin?
      params[:comment].delete(:state_id)
    end

    @comment = @ticket.comments.build(params[:comment].merge(:user => current_user))
    if @comment.save
      flash[:notice] = t("comments.created_msg")
      redirect_to [@project, @ticket]
    else
      @states = State.all
      flash[:alert] = t("comments.not_created_msg")
      render :template => "tickets/show"
    end
  end

  private
    def find_ticket
      @ticket = Ticket.find(params[:ticket_id])
      @project = @ticket.project
    end
end
