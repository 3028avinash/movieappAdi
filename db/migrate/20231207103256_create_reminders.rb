class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.integer :content_id
      t.boolean :status

      t.timestamps
    end
  end
end
