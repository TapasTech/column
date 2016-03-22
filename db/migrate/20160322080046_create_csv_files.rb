# frozen_string_literal: true
class CreateCSVFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :csv_files do |t|
      t.text :path
      t.references :dataset, foreign_key: true
      t.text :status, null: false, default: 'created'

      t.timestamps
    end
    add_index :csv_files, :status
  end
end
