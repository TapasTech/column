# frozen_string_literal: true
class DatasetColumn < ApplicationRecord
  belongs_to :dataset

  as_enum :column_type, [:string, :numeric, :date], map: :string,
                                                    source: :column_type
end
