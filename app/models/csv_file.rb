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

  module FilenameWithCSV
    def filename
      super || csv.filename.split('.').first
    end
  end

  prepend FilenameWithCSV

  attr_reader :path

  def path
    @path ||= csv.current_path
  end

  def csv_data
    csv_data = CSV.generate do |csv|
      headers = dataset.dataset_columns.map(&:name)
      csv << headers
      dataset.dataset_rows.each do |row|
        csv << headers.map{|h| row.dataset_attributes[h]}
      end
    end
    csv_data
  end

  def convert_to_excel_file
    excel = Spreadsheet::Workbook.new
    sheet = excel.create_worksheet name: filename

    header_format = Spreadsheet::Format.new(weight: :bold, horizontal_align: :center, locked: true)
    sheet.row(0).default_format = header_format

    headers = dataset.dataset_columns.map(&:name)
    sheet.row(0).replace headers

    dataset.dataset_rows.each_with_index do |row, i|
      row_data = headers.map{|h| row.dataset_attributes[h]}
      sheet.row(i+1).replace(row_data)
    end
    generate_excel_file excel
  end

  private

  def generate_excel_file(excel)
    file = Tempfile.new(filename)

    begin
      excel.write file.path
    ensure
      file.close
    end

    file
  end
end
