class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def authenticate_admin!
    unless current_user.try(:is_admin)
      flash[:alert] = '権限がありません'
      redirect_to root_path and return
    end
  end

  def redirect_to_root
    flash[:alert] = 'このページにはアクセスできません'
    redirect_to root_path and return
  end
end
