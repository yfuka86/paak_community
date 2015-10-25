class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships/1/edit
  def edit
    @user_candidate = User.candidate
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    if @membership.update(membership_params)
      redirect_to @membership.period, notice: 'メンバーシップが編集されました' and return
    else
      @user_candidate = User.candidate
      render :edit
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    if @membership.destroy
      redirect_to @membership.period, notice: 'メンバーシップが削除されました' and return
    else
      render :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:paak_id, :user_id, :period_id, :name)
    end
end
