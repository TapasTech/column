# frozen_string_literal: true
class CreateDatasetRows < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :dataset_rows do |t|
      t.references :dataset, foreign_key: true
      t.hstore :dataset_attributes

      t.timestamps
    end
    add_index :dataset_rows, :dataset_attributes, using: :gin
  end
end
