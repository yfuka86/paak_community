class Api::BaseController < ApplicationController
  rescue_from Exception, with: :render_error
  rescue_from ActionView::MissingTemplate, with: :render_not_found

  def render_success(message='')
    @_success = true
    render(
      json: {success: true, message: message},
      status: 200
    )
  end

  def render_error(error, options = {})
    message = ''
    messages = nil
    if error.is_a?(Exception)
      message = error.message
    elsif error.is_a?(Array)
      messages = error
    elsif error.is_a?(Hash)
      message = error[:message]
    elsif error.is_a?(String)
      message = error
    end

    status = options[:status] || :internal_server_error
    render(
      json: {errors: messages, error: message},
      status: status
    )
  end

  def render_not_found(e = nil)
    render(
        json: {message: 'not found'},
        status: :not_found
    )
  end

  def authenticate_user!
    if current_user.blank?
      render(
        json: {error: 'unauthorized'},
        status: :unauthorized
      )
    end
  end

  def authenticate_member!
    if current_user && !current_user.is_admin && current_user.periods.blank?
      render(
        json: {error: 'unauthorized'},
        status: :unauthorized
      )
    end
  end
end