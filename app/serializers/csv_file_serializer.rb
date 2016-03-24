# frozen_string_literal: true
class CSVFileSerializer < ActiveModel::Serializer
  attributes :id, :status, :error_message
  belongs_to :dataset
end
