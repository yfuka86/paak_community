class PeriodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_period, only: [:show, :edit, :update, :add_member, :destroy]

  def index
    @periods = Period.all
  end

  def show
    @memberships = @period.memberships
    @user_candidate = User.all
  end

  def new
    @period = Period.new
  end

  def edit
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      redirect_to @period, notice: 'Period was successfully created.' and return
    else
      render :new
    end
  end

  def update
    if @period.update(period_params)
      redirect_to @period, notice: 'Period was successfully updated.' and return
    else
      render :edit
    end
  end

  def add_member
    Membership.create({period_id: @period.id}.merge(add_member_params))
    redirect_to @period, notice: 'メンバーが追加されました' and return
  end

  def destroy
    if @period.destroy
      redirect_to periods_url, notice: 'Period was successfully destroyed.' and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:number, :code, :explanation)
    end

    def add_member_params
      params.permit(:paak_id, :user_id, :name)
    end
end
