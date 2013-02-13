class UsersController < ApplicationController
  before_filter :load_user_from_url, only: [:show, :edit, :update, :destroy, :setup_flickr]
  before_filter :authentication_required, only: [:edit, :update, :destroy, :setup_flickr, :finish_flickr]
  before_filter :ensure_user_is_current_user, only: [:edit, :update, :destroy, :setup_flickr]

  def show
  end

  def new
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Account udpated!"
      redirect_to user_path @user
    else

    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Welp. You deleted your account. Sorry to see you go!"
      redirect_to destroy_session_path
    else
      flash[:error] = "Bwahahahahhaha! Account deletion failed. Seriously though, I have no idea why."
      redirect_to user_path @user
    end
  end

  def setup_flickr
    @user = current_user
    @user.flickr_token = nil
    @user.save
  end

  def finish_flickr
    @user = current_user
    @flickr = @user.flickr_client
    if params.include?(:frob)
      @flickr.auth.frob = params[:frob]
      @user.update_attribute(:flickr_token, @flickr.auth.token)
      flash[:success] = 'Flickr was successfully authorized!'
      redirect_to help_path
    else
      flash[:error] = 'Flickr failed to authorize :/'
      render :action => 'setup_flickr'
    end
  end

  protected

  def load_user_from_url
    @user = User.where(username: params[:id]).first
    not_found if @user.nil?
  end
end
