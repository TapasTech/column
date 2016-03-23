# frozen_string_literal: true
class DatasetRow < ApplicationRecord
  belongs_to :dataset, -> { includes(:dataset_columns) }
  counter_culture :dataset

  # validate :attributes_exists

  # protected

  # def attributes_exists
  #   dataset.column_names.each do |column_name|
  #     check_attribute(column_name)
  #   end
  # end

  # def check_attribute(column)
  #   errors.add(column, "can't be blank") if dataset_attributes[column].nil?
  # end
end
