class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)

    if @user && @user.persisted?
      session[:user_id] = @user.id
      redirect_to request.env["omniauth.origin"] || root_path
    else
      redirect_to auth_unauthorised_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t("auth.logged_out")
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
