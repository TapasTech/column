# frozen_string_literal: true
class AddDatasetRowsCountToDatasets < ActiveRecord::Migration
  def self.up
    add_column :datasets, :dataset_rows_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :datasets, :dataset_rows_count
  end
end
