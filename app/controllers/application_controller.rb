# frozen_string_literal: true
class ApplicationController < ActionController::API
  include UserAuthenticatable
  include ActiveRecordErrorHandlable

  def pagination_dict(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end
end
