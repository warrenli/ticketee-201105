class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    projects = Project.readable_by(@current_user)
    respond_with(projects)
  end
end
