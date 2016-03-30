# frozen_string_literal: true
# Serialize Dataset in list
class DatasetPreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :dataset_rows_count
  has_many :dataset_columns

  def dataset_columns
    # Use in-memory sort instead of database order sort
    # since database order sort cannot take advantage of ActiveRecord#includes
    # and will produce n+1 query
    object.dataset_columns.sort_by(&:id)
  end
end
