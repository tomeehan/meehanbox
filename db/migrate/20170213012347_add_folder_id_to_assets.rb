class AddFolderIdToAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :folder_id, :integer
  end
end
