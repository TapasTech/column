# frozen_string_literal: true
class CSVParser
  include CSVParser::TypeCheck
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
    open_csv do |chunk|
      chunk.each do |row|
        check_row(row)
      end
    end
    columns
  end

  def finish_dataset
    Dataset.transaction do
      init_dataset
      fill_columns
      fill_rows
      mark_processed
    end
    dataset
  end

  protected

  attr_accessor :csv_file, :dataset, :encoding

  DETECTING_BUFFER_SIZE = 1.kilobytes

  def encoding
    @encoding ||=
      File.open(csv_file.csv.current_path, 'r') do |csv|
        CharlockHolmes::EncodingDetector.detect(csv.read(DETECTING_BUFFER_SIZE))[:encoding]
      end
  end

  def open_csv(&_block)
    SmarterCSV.process(csv_file.csv.current_path, chunk_size: 10,
                                                  convert_values_to_numeric: true,
                                                  file_encoding: encoding,
                       &_block)
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
    open_csv do |chunk|
      chunk.each do |row|
        dataset.dataset_rows.create!(dataset_attributes: row)
      end
    end
  end

  def mark_processed
    csv_file.update!(dataset: dataset, status: :processed)
  end

  class << self
    def parse(csv_file)
      CSVParser.new(csv_file).parse!
    end
  end
end
