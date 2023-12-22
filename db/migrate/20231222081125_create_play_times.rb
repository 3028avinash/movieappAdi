class CreatePlayTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :play_times do |t|
      t.references :user, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true
      t.string :time

      t.timestamps
    end
    add_index :play_times, [:user_id, :episode_id], unique: true
  end
end
