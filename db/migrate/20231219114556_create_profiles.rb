class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 50
      t.integer :age
      t.string :gender, limit: 15
      t.string :mobile, limit: 15

      t.timestamps
    end
  end
end
