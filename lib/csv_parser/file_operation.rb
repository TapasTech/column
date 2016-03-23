# frozen_string_literal: true
class CSVParser
  # Handling csv file
  module FileOperation
    attr_accessor :encoding

    DETECTING_BUFFER_SIZE = 1.kilobytes

    def encoding
      @encoding ||=
        File.open(csv_file.csv.current_path, 'r') do |csv|
          CharlockHolmes::EncodingDetector.detect(csv.read(DETECTING_BUFFER_SIZE))[:encoding]
        end
    end

    def open_csv(&block)
      SmarterCSV.process(csv_file.csv.current_path, chunk_size: 10,
                                                    convert_values_to_numeric: true,
                                                    file_encoding: encoding,
                         &block)
    end
  end
end
