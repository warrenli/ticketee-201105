class Admin::StatesController < ApplicationController
  def index
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(params[:state])
    if @state.save
      flash[:notice] = t('admin_state.created_msg')
      redirect_to admin_states_path
    else
      flash[:alert] = t('admin_state.not_created_msg')
      render :action => "new"
    end
  end
end
