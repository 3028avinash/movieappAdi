class AddColumnToSubscriptionHistory < ActiveRecord::Migration[7.0]
  def change
    add_column :subscription_histories, :status, :string, default: :pending1
    add_reference :subscription_histories, :payement_detail, null: false, foreign_key: true
    add_index :subscription_histories, [:user_id], unique: true, where: "status = 'active'"

  end
end
