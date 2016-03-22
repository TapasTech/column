# frozen_string_literal: true
class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.text :title

      t.timestamps
    end
  end
end
