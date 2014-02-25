class PostsController < ApplicationController
  before_filter :reset_session, except: [:show]
  before_filter :authenticate_with_oauth_echo, except: [:show]
  # before_filter :force_utf8_params, only: [:create]
  skip_before_filter :verify_authenticity_token

  def show
    @post = Post.where(short_id: params[:id]).first
    redirect_to @post.flickr_url rescue not_found
  end

  def create
    if current_user && params[:media].present? && current_user.flickr_token.present?
      post_params = params.clone
      post_params.keep_if{ |key| ['media', 'source', 'message'].include? key }
      @post = Post.new(post_params)
      @post.user = current_user
      if @post.save
        response = @post.as_response
      else
        response = {errors: @post.errors, status: 400}
      end
      respond_to do |format|
        format.xml {render xml: response, status: (response[:status] rescue 200) }
        format.json {render json: response, status: (response[:status] rescue 200) }
      end
    else
      err = "Missing "
      err += "valid user " unless current_user
      err += "upload file " unless params[:media].present?
      err += "valid flickr token " unless current_user.flickr_token.present?
      err += "in request from client."
      response = {error: err, status: 400}
      respond_to do |format|
        format.xml {render xml: response, status: 400}
        format.xml {render json: response, status: 400}
      end
    end
  end

  def create_from
    method = "create_from_#{CGI::escape(params[:service])}".to_sym
    if self.respond_to? method
      send method
    else
      not_found
    end
  end

  protected

  def authenticate_with_oauth_echo
    require 'httparty'
    # header auth only for now; also lock down the auth provider so we can't spoof
    if request.env["HTTP_X_AUTH_SERVICE_PROVIDER"] =~ /^https:\/\/api\.twitter\.com\//
      auth_service_provider = request.env["HTTP_X_AUTH_SERVICE_PROVIDER"]
      verify_credentials_authorization = request.env["HTTP_X_VERIFY_CREDENTIALS_AUTHORIZATION"]
      auth_response = HTTParty.get(auth_service_provider, :format => :json, :headers => {'Authorization' => verify_credentials_authorization})
      if !auth_response['screen_name'].blank?
        log_in_user User.where(username: auth_response['screen_name']).first
        return true
      end
    end
    return false
  end

end
