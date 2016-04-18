class AddDescriptionToDataset < ActiveRecord::Migration[5.0]
  def change
    add_column :datasets, :description, :string
  end
end
