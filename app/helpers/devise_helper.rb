module DeviseHelper
  def devise_error_messages!
    return "" if !defined?(resource) || resource.try(:errors).blank?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <p class='bg-danger sub-notification'>
        #{errmsg}
      </p>
      EOF
    end
    html.html_safe
  end
end