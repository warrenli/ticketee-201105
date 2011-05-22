class Api::V1::ProjectsController < Api::V1::BaseController
  before_filter :authorize_admin!, :except => [:index, :show]

  def index
    projects = Project.readable_by(@current_user)
    respond_with(projects)
  end

  def create
    project = Project.create(params[:project])
    if project.valid?
      respond_with(project, :location => api_v1_project_path(project))
    else
      respond_with(project)
    end
  end

  def show
    project = Project.find(params[:id])
    respond_with(project, :methods => "last_ticket")
  end
end
