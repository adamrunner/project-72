class NotAuthorizedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthorizedException, with: -> { not_authorized }
    rescue_from JWT::DecodeError,       with: -> { not_authorized }

  end

  private

  def authenticate_user
    @current_user = DecodeAuthenticationCommand.call(request.headers).result
    raise NotAuthorizedException unless @current_user
  end

  def not_authorized
    render json: { error: 'Not Authorized' }, status: 401
  end

end