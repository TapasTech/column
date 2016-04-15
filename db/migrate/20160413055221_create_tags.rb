# frozen_string_literal: true
class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :key
      t.string :value
      t.string :name

      t.timestamps
    end

    add_index :tags, :key
    add_index :tags, :value
    add_index :tags, :name
  end
end
