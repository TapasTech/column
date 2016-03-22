# frozen_string_literal: true
class AddCSVToCSVFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :csv_files, :csv, :text
  end
end
