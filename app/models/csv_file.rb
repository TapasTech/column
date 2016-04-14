# frozen_string_literal: true
require 'spreadsheet'
require 'csv'
require 'tempfile'

class CSVFile < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :dataset, required: false, dependent: :destroy
  mount_uploader :csv, CSVUploader

  as_enum :status, [:created, :processed, :invalid], map: :string,
                                                     source: :status,
                                                     accessor: :whiny
  delegate :title, to: :dataset

  # mapping path attribute to csv current_path
  module PathWithCSV
    def path
      super || csv.current_path
    end
  end

  prepend PathWithCSV

  def convert_to_excel_file
    excel = Spreadsheet::Workbook.new
    sheet = excel.create_worksheet name: title

    header_format = Spreadsheet::Format.new(weight: :bold, horizontal_align: :center, locked: true)
    sheet.row(0).default_format = header_format
    encoding = CSVParser.new(self).encoding

    CSV.foreach(path, encoding: encoding).with_index do |row, i|
      sheet.row(i).replace(row)
    end

    generate_excel_file excel
  end

  private

  def generate_excel_file(excel)
    file = Tempfile.new(title)

    begin
      excel.write file.path
    ensure
      file.close
    end

    file
  end
end
