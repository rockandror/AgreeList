class NewController < ApplicationController
  def index
    @agreements = Agreement.order(created_at: :desc).limit(30).joins(:individual).joins(:statement)
  end
end
