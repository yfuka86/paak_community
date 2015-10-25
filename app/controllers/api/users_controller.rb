class Api::UsersController < Api::BaseController
  def index
    @current_memberships = Membership.current_in_paak.includes(:user)

    render json: {
      users: @current_memberships.map do |m|
        {
          id: m.user.id,
          name: m.user.name,
          image_url: m.user.image_url,
          facebook_url: m.user.try(:facebook_url),
          latest_period: m.user.latest_period.try(:explanation)
        }
      end
      }.to_json
  end
end