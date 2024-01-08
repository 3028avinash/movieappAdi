class CreateFavoriteLists < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favorite_lists, [:user_id, :episode_id], unique: true
  end
end
