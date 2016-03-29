# frozen_string_literal: true
class AddUserToDatasets < ActiveRecord::Migration[5.0]
  def change
    add_reference :datasets, :user, foreign_key: true
  end
end
