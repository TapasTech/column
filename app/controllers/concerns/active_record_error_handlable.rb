# frozen_string_literal: true
# Handle active record errors
# Validation Error => 422
# Constraint Error => 422
module ActiveRecordErrorHandlable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotUnique, with: :unprocessable_entity

    def unprocessable_entity(error)
      render json: {error: error.message}, status: :unprocessable_entity
    end
  end
end
