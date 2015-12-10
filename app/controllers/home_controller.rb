class HomeController < ApplicationController
  def index
    @statement = Rails.env.production? ? Statement.find(7) : Statement.first
  end
  def save_email
    BetaEmail.create(email: params[:email], comment: params[:vote])
    LogMailer.log_email("#{params[:email]} #{params[:vote]}").deliver
    redirect_to statement_path(brexit)
  end

  private

  def brexit
    Statement.find_by_content("Should the UK remain a member of the EU?")
  end
end
