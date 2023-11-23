class CreateAppopens < ActiveRecord::Migration[7.0]
  def change
    create_table :appopens do |t|
      t.integer :user_id
      t.string :source_ip
      t.string :location
      t.string :version_name
      t.string :version_code

      t.timestamps
    end
  end
end
