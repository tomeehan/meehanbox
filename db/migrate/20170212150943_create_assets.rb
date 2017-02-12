class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer :user_id

      t.timestamps
      add_index :assets, :user_id
    end
  end
end
