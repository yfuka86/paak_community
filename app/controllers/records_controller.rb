class RecordsController < ApplicationController
  def index
    Time.zone = 'Tokyo'
    date = params[:period].try(:to_date) || Time.now.to_date

    @records = Record.order(timestamp: :desc).where('timestamp >= ? AND timestamp < ?', date, date + 1.day)
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

  def update
    @record = Record.find_by(id: params[:id])
    @record.memo = params[:memo]
    if @record.save!
      redirect_to records_path, notice: 'メモが変更されました' and return
    else
      render :back, alert: 'メモの編集に失敗しました' and return
    end
  end

  def leave
    @old_record = Record.find_by(id: params[:id])
    @record = Record.new(membership: @old_record.membership, timestamp: DateTime.now, card_id: @old_record.card_id)
    @record.leave!
    if @record.save!
      redirect_to records_path, notice: '退館が完了しました' and return
    else
      render :back, alert: '退館に失敗しました' and return
    end
  end
end
