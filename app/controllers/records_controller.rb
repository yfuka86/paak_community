class RecordsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @records = Record.order(timestamp: :desc).limit(100)
  end

  def create
    redirect_to :back, alert: '会員種別を指定してください' and return unless params[:period_code].present?

    membership = Membership.by_period_code(params[:period_code]).find_by(paak_id: params[:paak_id])
    redirect_to :back, alert: '存在しない会員です' and return unless membership

    @record = Record.new(membership: membership, timestamp: DateTime.now, card_id: params[:card_id], memo: params[:memo])
    if params[:commit].to_sym == :enter then @record.enter! else @record.leave! end

    if @record.save
      redirect_to records_path, notice: '記録が残されました' and return
    else
      render :back, alert: '記録に失敗しました'
    end
  end
end
