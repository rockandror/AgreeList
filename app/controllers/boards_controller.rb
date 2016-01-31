class BoardsController < ApplicationController
  def brexit
    @statement = main_statement
    categories = ReasonCategory.includes(:agreements)
    @categories_in_favor = categories.where(agreements: {extent: 100})
    @categories_against = categories.where(agreements: {extent: 0})
   
  end
end
