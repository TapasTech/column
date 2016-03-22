# frozen_string_literal: true
class ProcessCSVJob < ApplicationJob
  queue_as :default

  def perform(csv_file_id)
    @csv_file = CSVFile.find(csv_file_id)
    CSVParser.parse(csv_file)
  end
end
