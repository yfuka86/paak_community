class Api::RecordsController < Api::BaseController
  def latest_ts
    render json: {
      ts: Record.order(timestamp: :desc).first.try(:timestamp).try(:to_i) || 1
      }.to_json
  end
end
