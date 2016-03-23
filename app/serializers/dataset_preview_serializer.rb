# frozen_string_literal: true
class DatasetPreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :dataset_rows_count
  has_many :dataset_columns
end
