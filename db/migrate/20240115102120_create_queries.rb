class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :query_type
      t.text :message

      t.timestamps
    end
  end
end
