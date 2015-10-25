class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  skip_before_action :authenticate_member!, only: [:index, :pending]

  def index
    if current_user
      redirect_to current_url and return
    end
  end

  def pending
    if current_user && (current_user.is_admin || current_user.periods.present?)
      redirect_to current_url and return
    end
  end

  def current
    @current_memberships = Membership.current_in_paak.includes(:user)
  end
end
