class ContentController < ApplicationController
  def index
    if current_user
      redirect_to setup_flickr_for_user_path current_user and return unless current_user.flickr_token.present?
      redirect_to user_path current_user and return
    end
  end

  def about
  end

  def help
  end

end