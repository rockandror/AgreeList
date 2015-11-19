class NewController < ApplicationController
  def index
    @agreements = Agreement.order(updated_at: :desc).limit(30).joins(:individual).joins(:statement)
    @statement = Statement.new
  end

  def vote
    agreement = Agreement.where(statement_id: params[:statement_id], individual_id: current_user.id).first
    if agreement
      agreement.extent = extent
    else
      agreement = Agreement.new(
        statement_id: params[:statement_id],
        individual_id: current_user.id,
        extent: params[:vote] == "agree" ? 100 : 0)
    end
    agreement.save
    redirect_to action: :index
  end

  private

  def extent
    params[:vote] == "agree" ? 100 : 0
  end
end
