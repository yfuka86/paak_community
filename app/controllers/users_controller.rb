class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:accept, :destroy]
  before_action :set_user, only: [:show, :edit, :accept, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @accepted_users = User.accepted
    @unaccepted_users = User.unaccepted
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
    check_user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    check_user
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.' and return
    end
  end

  def accept

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.' and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def check_user
      redirect_to root_path and return if !current_user.is_admin && current_user != @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:paak_id, :type, :project_id, :name, :url, :image_url, :summary)
    end
end
