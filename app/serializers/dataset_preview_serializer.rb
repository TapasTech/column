# frozen_string_literal: true
class DatasetPreviewSerializer < DatasetSerializer
  def dataset_rows
    object.dataset_rows.order(id: :asc).limit(5)
  end
end
