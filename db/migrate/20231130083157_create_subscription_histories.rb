class CreateSubscriptionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_histories do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.string :subscription_start
      t.string :subscription_end
      t.integer :coupon_id

      t.timestamps
    end
  end
end
