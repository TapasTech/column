# frozen_string_literal: true
class CSVParser
  attr_accessor :columns, :rows

  def initialize(csv_file)
    @csv_file = csv_file
    @columns = {}
  end

  def parse!
    analyze_columns
    finish_dataset
  end

  def analyze_columns
    SmarterCSV.process(csv_file.csv.current_path, chunk_size: 10,
                                                  convert_values_to_numeric: true) do |chunk|
      chunk.each do |row|
        check_row(row)
      end
    end
  end

  def finish_dataset
    Dataset.transaction do
      init_dataset
      fill_columns
      fill_rows
    end
    dataset
  end

  protected

  attr_accessor :csv_file, :dataset

  # Check row type
  def check_row(row)
    row.each_key do |key|
      check_column(key, row[key])
    end
  end

  def check_column(key, value)
    columns[key] ||= type_of(value)
    columns[key] = :string if columns[key] != type_of(value)
  end

  def type_of(value)
    return nil if value.nil?
    return :numeric if value.is_a? Numeric
    return :date if Time.zone.parse(value)
  rescue ArgumentError, TypeError
    :string
  end

  # Save Dataset
  def init_dataset
    @dataset = (csv_file.dataset || csv_file.create_dataset!)
  end

  def fill_columns
    column_params = columns.map do |name, column_type|
      {
        name: name,
        column_type: column_type
      }
    end
    dataset.dataset_columns.create!(column_params)
  end

  def fill_rows
    SmarterCSV.process(csv_file.csv.current_path, chunk_size: 10,
                                                  convert_values_to_numeric: true) do |chunk|
      chunk.each do |row|
        dataset.dataset_rows.create!(dataset_attributes: row)
      end
    end
  end

  class << self
    def parse(csv_file)
      CSVParser.new(csv_file).parse!
    end
  end
end
