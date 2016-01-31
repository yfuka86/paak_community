class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
  skip_before_action :authenticate_member!, only: [:index, :pending]
  skip_before_action :authenticate_admin!

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

  def events
    render json: {
      events: GoogleAPIClient.get_calendar_events
    }
  end

  def current
  end
end
