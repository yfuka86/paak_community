class Api::EventsController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:index]
  skip_before_action :authenticate_member!, only: [:index]
  skip_before_action :authenticate_admin!, only: [:index]

  def index
    render json: {
      events: GoogleAPIClient.get_calendar_events
    }
  end
end
