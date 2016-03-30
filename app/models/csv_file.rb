# frozen_string_literal: true
class CSVFile < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :dataset, required: false, dependent: :destroy
  mount_uploader :csv, CSVUploader

  as_enum :status, [:created, :processed, :invalid], map: :string,
                                                     source: :status,
                                                     accessor: :whiny
end
