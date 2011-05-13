class TicketsController < ApplicationController
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def edit
  end

  def create
    @ticket = @project.tickets.build(params[:ticket])
    if @ticket.save
      flash[:notice] = t("tickets.created_msg")
      redirect_to [@project, @ticket]
    else
      flash[:error] = t("tickets.not_created_msg")
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = t("tickets.updated_msg")
      redirect_to [@project, @ticket]
    else
      flash[:error] = t("tickets.not_updated_msg")
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
      @project = Project.find(params[:project_id])
    end

    def find_ticket
      @ticket = @project.tickets.find(params[:id])
    end
end
