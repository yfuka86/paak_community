class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :authenticate_member!

  def authenticate_admin!
    unless current_user.try(:is_admin)
      flash[:alert] = '権限がありません'
      redirect_to root_path and return
    end
  end

  def authenticate_member!
    if current_user && !current_user.is_admin && current_user.periods.blank?
      redirect_to pending_path and return
    end
  end
end
