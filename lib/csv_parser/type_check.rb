# frozen_string_literal: true
class CSVParser
  # Determine type of each column
  module TypeCheck
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
      :string
    rescue ArgumentError, TypeError
      :string
    end
  end
end
