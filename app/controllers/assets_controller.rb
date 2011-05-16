class AssetsController < ApplicationController
  respond_to :html, :js

  def new
    @number = params[:number].to_i
  end

  def show
    asset = Asset.find(params[:id])
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path, :filename => asset.asset_file_name,
                                  :content_type => asset.asset_content_type
    else
      flash[:alert] = t("assets.cannot_show_msg")
      redirect_to root_path
    end
  end
end
