# frozen_string_literal: true
class Dataset < ApplicationRecord
  has_many :dataset_columns, dependent: :destroy
  has_many :dataset_rows, dependent: :destroy
  has_one :csv_file
  has_one :user, through: :csv_file

  attr_accessor :column_types

  def column_type_of(key)
    column_types[key]
  end

  def column_names
    column_types.keys
  end

  def column_types
    @column_types ||=
      Hash[
        dataset_columns.map { |c| [c.name, c.column_type] }
      ]
  end

  def attach_tag(tag)
    tags << tag.tag_str
    tags = tags.uniq! || []
    tags
  end

  class << self
    def join_dataset(dataset, compare_dataset, join_attribute:, compare_join_attribute:nil, attribute:, compare_attribute:)
      DatasetRow.joins(sanitize_join(join_attribute, compare_join_attribute || join_attribute))
                .where('dataset_rows.dataset_id = ?', dataset.id)
                .where('compare_rows.dataset_id = ?', compare_dataset.id)
                .select(sanitize_select(join_attribute, attribute, compare_attribute))
                .order('dimense ASC')
    end

    protected

    def sanitize_join(join_attribute, compare_join_attribute)
      sanitized_join_attribute = sanitize(join_attribute)
      sanitized_compare_join_attribute = sanitize(compare_join_attribute)
      "FULL OUTER JOIN dataset_rows AS compare_rows ON \
      (dataset_rows.dataset_attributes->#{sanitized_join_attribute}) ~ \
      (compare_rows.dataset_attributes->#{sanitized_compare_join_attribute})"
    end

    def sanitize_select(join_attribute, attribute, compare_attribute)
      sanitized_join_attribute = sanitize(join_attribute)
      sanitized_attribute = sanitize(attribute)
      sanitized_compare_attribute = sanitize(compare_attribute)
      "dataset_rows.dataset_attributes->#{sanitized_join_attribute} AS dimense, \
      dataset_rows.dataset_attributes->#{sanitized_attribute} AS attribute, \
      compare_rows.dataset_attributes->#{sanitized_compare_attribute} AS compare_attribute"
    end
  end
end
