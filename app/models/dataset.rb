# frozen_string_literal: true
class Dataset < ApplicationRecord
  has_many :dataset_columns
  has_many :dataset_rows

  class << self
    def join_dataset(dataset, compare_dataset, join_attribute:, compare_join_attribute:nil, attribute:, compare_attribute:)
      DatasetRow.joins(sanitize_join(join_attribute, compare_join_attribute || join_attribute))
                .where('dataset_rows.dataset_id = ?', dataset.id)
                .where('compare_rows.dataset_id = ?', compare_dataset.id)
                .select(sanitize_select(join_attribute, attribute, compare_attribute))
    end

    protected

    def sanitize_join(join_attribute, compare_join_attribute)
      sanitized_join_attribute = sanitize(join_attribute)
      sanitized_compare_join_attribute = sanitize(compare_join_attribute)
      "INNER JOIN dataset_rows AS compare_rows ON \
      (dataset_rows.dataset_attributes->#{sanitized_join_attribute}) ~ \
      (compare_rows.dataset_attributes->#{sanitized_compare_join_attribute})"
    end

    def sanitize_select(join_attribute, attribute, compare_attribute)
      sanitized_join_attribute = sanitize(join_attribute)
      sanitized_attribute = sanitize(attribute)
      sanitized_compare_attribute = sanitize(compare_attribute)
      "dataset_rows.dataset_attributes->#{sanitized_join_attribute} AS dimense,
            dataset_rows.dataset_attributes->#{sanitized_attribute} AS attribute,
            compare_rows.dataset_attributes->#{sanitized_compare_attribute} AS compare_attribute"
    end
  end
end
