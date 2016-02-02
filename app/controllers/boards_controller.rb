class BoardsController < ApplicationController
  def brexit
    @statement = main_statement
    categories = ReasonCategory.includes(:agreements)
    @categories_in_favor = categories.where(agreements: {extent: 100})
    @categories_against = categories.where(agreements: {extent: 0})
    agreements = Agreement.where(statement: @statement)
    agreements_in_favor = agreements.where(agreements: {extent: 100})
    agreements_against = agreements.where(agreements: {extent: 0})
    @votes_in_favor_without_category_count = agreements_in_favor.where(reason_category_id: nil).count
    @votes_against_without_category_count = agreements_against.where(reason_category_id: nil).count
    votes_in_favor = agreements_in_favor.count
    @percentage_in_favor = (votes_in_favor * 100.0 / Agreement.where(statement: @statement).count).round
  end
end
