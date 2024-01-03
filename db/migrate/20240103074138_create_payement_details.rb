class CreatePayementDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :payement_details do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.string :order_id
      t.string :payement_id
      t.float :amount

      t.timestamps
    end
  end
end
