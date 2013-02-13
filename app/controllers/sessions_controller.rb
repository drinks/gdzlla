class SessionsController < ApplicationController

  def new
    session[:request_token] = GDZLLA.twitter_consumer.get_request_token oauth_callback: create_session_url
    redirect_to "#{session[:request_token].authorize_url}"
  end

  def create
    access_token = session[:request_token].get_access_token oauth_token: params[:oauth_token], oauth_verifier: params[:oauth_verifier]
    user = User.find_or_initialize_by username: access_token.params[:screen_name]
    user.twitter_token = access_token.params[:oauth_token].to_s
    user.twitter_secret = access_token.params[:oauth_token_secret].to_s
    if user.save
      log_in_user(user)
      redirect_to root_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
