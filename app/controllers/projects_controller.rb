class ProjectsController < ApplicationController
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = t("projects.created_msg")
      redirect_to @project
    else
      flash[:alert] = t("projects.not_created_msg")
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = t("projects.updated_msg")
      redirect_to @project
    else
      flash[:error] = t("projects.not_updated_msg")
      render :action => "edit"
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = t("projects.deleted_msg")
    redirect_to projects_path
  end

  private
    def find_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = t("projects.not_found_msg")
      redirect_to projects_path
    end
end
