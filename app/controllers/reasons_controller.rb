class ReasonsController < ApplicationController
  def edit
    @agreement = Agreement.find(params[:id])
  end

  def update
    Agreement.update_attributes(params.require(@agreement).permit(:reason))
    redirect_to params[:back_url] || root_path
  end
end
