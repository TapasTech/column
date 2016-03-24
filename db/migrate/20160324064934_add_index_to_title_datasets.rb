# frozen_string_literal: true
class AddIndexToTitleDatasets < ActiveRecord::Migration[5.0]
  def change
    add_index :datasets, :title
  end
end
