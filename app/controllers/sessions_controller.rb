class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = Individual.find_by_twitter(auth["info"]["nickname"].downcase) || Individual.create_with_omniauth(auth)
    session[:user_id] = user.id
    LogMailer.log_email("#{user.name} (@#{user.twitter}) just signed in!").deliver
    if params["task"] == "voting"
      Vote.new(
        statement_id: params["statement_id"],
        individual_id: user.id,
        extent: params["vote"] == "agree" ? 100 : 0
      ).vote!
    elsif params["task"] == "post"
      s = Statement.create(content: params["content"])
      Vote.new(
        statement_id: s.id,
        individual_id: user.id,
        extent: 100
      ).vote!
    end
    # redirect_to user.email.present? ? "/statement" : "/join", :notice => "Signed in!"
    redirect_to(params[:back_url] || root_path, notice: "Signed in!")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
