# frozen_string_literal: true
class ChangeCSVFiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :csv_files, :path, :string
    add_column :csv_files, :filename, :string
  end
end
