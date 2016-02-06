class BoardsController < ApplicationController
  def brexit
    @statement = main_statement
    categories = ReasonCategory.includes(:agreements)
    @categories_in_favor = categories.where(agreements: {extent: 100}).sort_by{|c| - c.agreements.size} << InFavorOthersCategory.new(statement: @statement)
    @categories_against = categories.where(agreements: {extent: 0}).sort_by{|c| - c.agreements.size} << AgainstOthersCategory.new(statement: @statement)
    agreements = Agreement.where(statement: @statement)
    votes_in_favor = agreements.where(agreements: {extent: 100}).count
    @percentage_in_favor = (votes_in_favor * 100.0 / Agreement.where(statement: @statement).count).round
  end
end
