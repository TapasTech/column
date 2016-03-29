# frozen_string_literal: true
# Authenticate users in controller
# Login Error           => 401
# Invalid Token         => 401
# Missing Token         => 401
module UserAuthenticatable
  extend ActiveSupport::Concern

  included do
    rescue_from ColumnCustomError::LoginError, with: :unauthorized

    def authenticate_user!
      fail ColumnCustomError::MissingToken if http_authorization.blank?
      fail ColumnCustomError::InvalidToken if current_user.blank?
    end

    def http_authorization
      @http_authorization ||= params['auth_token'] ||
                              request.headers['Http-Authorization'] ||
                              request.env['HTTP_AUTHORIZATION']
    end

    def current_user
      return nil if http_authorization.blank?

      auth_token = AuthToken.from_token http_authorization
      return nil unless auth_token.valid?

      auth_token.user
    end

    def unauthorized(error)
      render json: {error: error.message}, status: :unauthorized
    end
  end
end
