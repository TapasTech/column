# frozen_string_literal: true
Apipie.configure do |config|
  config.app_name                = 'Column'
  config.api_base_url            = ''
  config.doc_base_url            = '/apipie'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/{[!concerns/]**/*,*}.rb"
end

# hotfix HashValidator when rails params is actually a ActionController::Parameters
module CastHashBeforeValidation
  def validate(value)
    super(value.to_unsafe_h)
  rescue NoMethodError
    super(value)
  end
end

Apipie::Validator::HashValidator.prepend(CastHashBeforeValidation)
