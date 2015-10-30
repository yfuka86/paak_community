class Api::RecordsController < Api::BaseController
  skip_before_action :authenticate_admin!

  def latest_ts
    render json: {
      ts: Record.order(timestamp: :desc).first.try(:timestamp).try(:to_i) || 1
      }.to_json
  end
end
