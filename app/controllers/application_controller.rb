class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :admin?

  private

  def current_user
    @current_user ||= Individual.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def admin?
    %w(Emilie_Esposito arpahector).include?(current_user.try(:twitter))
  end

  def login_required
    redirect_to "/", notice: "login required" unless signed_in?
  end

  def admin_required
    redirect_to "/", notice: "admin required" unless admin?
  end

  def main_statement
    Rails.env.production? ? Statement.find(7) : Statement.first
  end
end
