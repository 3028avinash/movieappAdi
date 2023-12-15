class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :episode_id
      t.boolean :watch_list
      t.boolean :favorite_list

      t.timestamps
    end
  end
end
