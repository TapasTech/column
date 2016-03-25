# frozen_string_literal: true
class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :dataset_columns
  has_many :dataset_rows

  def dataset_rows
    object.dataset_rows.order(id: :asc).limit(5)
  end
end
