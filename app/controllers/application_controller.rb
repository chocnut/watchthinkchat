class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_by_facebook!
    return if signed_in?
    session[:return_to] = request.path
    session[:campaign] = nil
    redirect_to user_omniauth_authorize_path(:facebook)
  end

  def current_user
    super.try(:decorate)
  end

  def current_visitor
    super.try(:decorate)
  end
end
