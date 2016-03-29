# frozen_string_literal: true
class CSVParser
  # Handling csv file
  module FileOperation
    attr_accessor :encoding, :delimiter

    DETECTING_BUFFER_SIZE = 1.kilobytes
    DETECTING_LINE_LENGTH = 50
    CHUNK_SIZE = 20
    DELIMITERS = [',', ';', "\t"].freeze

    def encoding
      @encoding ||= detect_encoding
    end

    def delimiter
      @delimiter ||= detect_delimiter
    end

    def open_csv(&block)
      SmarterCSV.process(path, chunk_size: CHUNK_SIZE,
                               convert_values_to_numeric: true,
                               file_encoding: encoding,
                               col_sep: delimiter,
                               row_sep: :auto,
                               quote_char: '"',
                         &block)
    end

    def path
      csv_file.csv.current_path
    end

    private

    def detect_encoding
      File.open(path, 'r') do |csv|
        CharlockHolmes::EncodingDetector.detect(csv.read(DETECTING_BUFFER_SIZE))[:encoding]
      end
    end

    def detect_delimiter
      line_counts = DELIMITERS.map { |delimiter| delimiter_line_count(delimiter) }
      DELIMITERS[line_counts.index(line_counts.max)]
    end

    def delimiter_line_count(delimiter)
      File.open(path, "r:#{encoding}") do |f|
        csv = CSV.new(f, col_sep: delimiter, row_sep: :auto, quote_char: '"')
        line_count_of_csv(csv)
      end
    end

    def line_count_of_csv(csv)
      Array.new(DETECTING_LINE_LENGTH)
           .map { csv&.readline&.count }
           .reduce { |a, e| (e&.!= a) ? 0 : a } # check if has same colum count => same: count; not: 0
    rescue CSV::MalformedCSVError
      0
    end
  end
end
