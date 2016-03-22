# frozen_string_literal: true
class DatasetColumnSerializer < ActiveModel::Serializer
  attributes :id, :name, :column_type
end
