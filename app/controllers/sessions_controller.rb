class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = Individual.find_by_twitter(auth["info"]["nickname"].downcase) || Individual.create_with_omniauth(auth)
    session[:user_id] = user.id
    LogMailer.log_email("#{user.name} (@#{user.twitter}) just signed in!").deliver
    # redirect_to user.email.present? ? "/statement" : "/join", :notice => "Signed in!"
    redirect_to "/new", notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
