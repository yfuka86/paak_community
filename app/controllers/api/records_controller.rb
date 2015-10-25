class Api::RecordsController < Api::BaseController
  def latest_ts
    render json: {
      ts:Record.order(timestamp: :desc).first.timestamp.to_i
      }.to_json
  end
end
