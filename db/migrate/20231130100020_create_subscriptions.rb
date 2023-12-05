class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :real_amount
      t.string :offer_amount
      t.string :duration
      t.boolean :status, default:false

      t.timestamps
    end
  end
end
