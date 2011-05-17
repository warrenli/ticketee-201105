class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_create!, :only => [:new, :create]
  before_filter :authorize_update!, :only => [:edit, :update]
  before_filter :authorize_delete!, :only => :destroy

  def show
    @comment = @ticket.comments.build
    @states = State.all
  end

  def new
    @ticket = @project.tickets.build
    @ticket.assets.build
    @assets_count = 0
  end

  def edit
    @assets_count = @ticket.assets.count
  end

  def create
    @ticket = @project.tickets.build(params[:ticket].merge!(:user => current_user))
    if @ticket.save
      flash[:notice] = t("tickets.created_msg")
      redirect_to [@project, @ticket]
    else
      flash[:alert] = t("tickets.not_created_msg")
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = t("tickets.updated_msg")
      redirect_to [@project, @ticket]
    else
      flash[:alert] = t("tickets.not_updated_msg")
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = t("tickets.deleted_msg")
    redirect_to @project
  end

  private

    def find_project
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t("projects.not_found_msg")
      redirect_to root_path
    end

    def find_ticket
      @ticket = @project.tickets.find(params[:id])
    end

    def authorize_create!
      if !current_user.admin? && cannot?("create tickets".to_sym, @project)
        flash[:alert] = t("tickets.not_authorized_to_create_msg")
        redirect_to @project
      end
    end

    def authorize_update!
      if !current_user.admin? && cannot?(:"edit tickets", @project)
        flash[:alert] = t("tickets.not_authorized_to_update_msg")
        redirect_to @project
      end
    end

    def authorize_delete!
      if !current_user.admin? && cannot?(:"delete tickets", @project)
        flash[:alert] = t("tickets.not_authorized_to_delete_msg")
        redirect_to @project
      end
    end
end
