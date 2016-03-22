# frozen_string_literal: true
class DatasetPreviewSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :dataset_columns
end
