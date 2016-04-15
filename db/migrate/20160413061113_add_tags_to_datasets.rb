# frozen_string_literal: true
class AddTagsToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :tags, :string, array: true, default: []
    add_index  :datasets, :tags, using: 'gin'
  end
end
