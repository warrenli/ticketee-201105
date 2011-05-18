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

  def make_default
    @state = State.find(params[:id])
    @state.default!

    flash[:notice] = t("admin_state.make_default_msg", :state_name => @state.name)
    redirect_to admin_states_path
  end
end
