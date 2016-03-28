# frozen_string_literal: true
class CSVParser
  # Handling csv file
  module FileOperation
    attr_accessor :encoding, :delimiter

    DETECTING_BUFFER_SIZE = 1.kilobytes
    CHUNK_SIZE = 20

    def encoding
      @encoding ||=
        File.open(csv_file.csv.current_path, 'r') do |csv|
          CharlockHolmes::EncodingDetector.detect(csv.read(DETECTING_BUFFER_SIZE))[:encoding]
        end
    end

    def delimiter
      @delimiter ||= /[\,\;\t]/
    end

    def open_csv(&block)
      SmarterCSV.process(csv_file.csv.current_path, chunk_size: CHUNK_SIZE,
                                                    convert_values_to_numeric: true,
                                                    file_encoding: encoding,
                                                    col_sep: delimiter,
                                                    row_sep: :auto,
                         &block)
    end
  end
end
