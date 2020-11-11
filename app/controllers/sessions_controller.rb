require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'googleauth/stores/file_token_store'

class SessionsController < ApplicationController
  before_action :require_logged_out, except: :destroy
  before_action :require_logged_in, only: :destroy
  before_action :prepare_google_auth, only: %i[oauth callback]

  def new
    @session = User.new
  end

  def create
    @session = User.new(session_params)
    user = User.find_by(email: @session.email)
    if user&.authenticate(@session.password)
      cookies.signed[:user_id] = user.id
      redirect_to root_path, notice: "Login successful"
    else
      render :new, alert: "Invalid Username and/or Password"
    end
  end

  def destroy
    cookies.delete :user_id
    redirect_to root_path
  end

  def oauth
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id:     @g_client_id.id,
      client_secret: @g_client_id.secret,
      scope:         @g_scope
    )
    auth_url = credentials.authorization_uri(
      access_type:            "offline",
      redirect_uri:           callback_session_url,
      include_granted_scopes: true,
    )
    redirect_to auth_url.to_s
  end

  def callback
    credential_refresh = @g_authorizer.get_and_store_credentials_from_code(code: params[:code])
    verify_opts = { aud: @g_client_id.id, azp: @g_client_id.id }
    user_info = Google::Auth::IDTokens.verify_oidc(credential_refresh.id_token)
    g_user_name = user_info['name']
    g_user_email = user_info['email']
    g_user_id = user_info['sub']
    user = User.find_by(google_user_id: g_user_id) || User.find_or_initialize_by(email: g_user_email)
    user.name = g_user_name
    user.email = g_user_email
    user.google_user_id = g_user_id
    user.save!
    
    cookies.signed[:user_id] = user.id
    redirect_to root_path, notice: "Login successful"
  end


private
  def session_params
    params.require(:user).permit(:email, :password)
  end
  
  def prepare_google_auth
    client_secret_file = Rails.root / 'config' / 'client_secret.json'
    token_store_path = Rails.root / 'config' / 'user_tokens.json'
    @g_client_id = Google::Auth::ClientId.from_file(client_secret_file.to_s)
    @g_scope = [
      'https://www.googleapis.com/auth/userinfo.email', 
      'openid', 
      'email',
      'https://www.googleapis.com/auth/userinfo.profile'
    ]
    @g_token_store = Google::Auth::Stores::FileTokenStore.new(file: token_store_path.to_s)
    @g_authorizer = Google::Auth::UserAuthorizer.new(@g_client_id, @g_scope, @g_token_store, callback_session_url)
  end

end
