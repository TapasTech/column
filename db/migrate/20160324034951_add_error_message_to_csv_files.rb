# frozen_string_literal: true
class AddErrorMessageToCSVFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :csv_files, :error_message, :text
  end
end
