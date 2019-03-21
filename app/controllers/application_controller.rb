class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery
  before_action :skip_session

  def authenticate
    render json: {errors: 'Unauthorized'}, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.(request.headers)
  end

  protected
  def skip_session
    request.session_options[:skip] = true
  end
end
