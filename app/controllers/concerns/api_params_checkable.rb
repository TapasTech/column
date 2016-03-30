# frozen_string_literal: true
# Check paramaters defined by apipie
module APIParamsCheckable
  extend ActiveSupport::Concern

  included do
    rescue_from Apipie::ParamError, with: :bad_request

    def bad_request(error)
      render json: {error: error.message}, status: :bad_request
    end
  end
end
