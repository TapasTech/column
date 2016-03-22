# frozen_string_literal: true
class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :dataset_columns
  has_many :dataset_rows
end
