# frozen_string_literal: true
class CSVFileSerializer < ActiveModel::Serializer
  attributes :id, :status
  belongs_to :dataset
end
