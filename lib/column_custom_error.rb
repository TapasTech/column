# frozen_string_literal: true
module ColumnCustomError
  # Custom Error Basic
  class BasicError < StandardError
    BASE_KEY = 'column.errors.messages'
    def initialize
      super(translated_message)
    end

    def translated_message(options={})
      key = self.class.name.demodulize.underscore

      ::I18n.translate("#{BASE_KEY}.#{key}", options)
    end
  end

  class LoginError < BasicError; end
  class MissingToken < BasicError; end
  class InvalidToken < BasicError; end
end
