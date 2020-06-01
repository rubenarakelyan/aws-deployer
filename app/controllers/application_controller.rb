class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user

  private

  def require_login
    redirect_to root_path, notice: I18n.t("auth.please_log_in") unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
