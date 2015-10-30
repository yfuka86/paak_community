class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :authenticate_admin!

  # GET /resource/password/new
  def new
    redirect_to_root
    # super
  end

  # POST /resource/password
  def create
    redirect_to_root
    # super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    redirect_to_root
    # super
  end

  # PUT /resource/password
  def update
    redirect_to_root
    # super
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
