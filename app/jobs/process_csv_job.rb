# frozen_string_literal: true
class ProcessCSVJob < ApplicationJob
  queue_as :default

  def perform(csv_file_id)
    # Do something later
  end
end
