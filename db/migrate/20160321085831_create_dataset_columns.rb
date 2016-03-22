# frozen_string_literal: true
class CreateDatasetColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :dataset_columns do |t|
      t.text :name
      t.references :dataset, foreign_key: true
      t.text :column_type

      t.timestamps
    end
    add_index :dataset_columns, :name
    add_index :dataset_columns, :column_type
  end
end
