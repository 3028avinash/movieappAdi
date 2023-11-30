class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :offer
      t.boolean :status, default:false

      t.timestamps
    end
  end
end
