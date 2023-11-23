class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :social_id
      t.text :social_token
      t.string :social_type
      t.string :social_imgurl
      t.string :social_email
      t.string :social_name
      t.string :device_id
      t.string :device_name
      t.string :device_type
      t.string :security_token
      t.string :advertising_id
      t.string :referral_code
      t.string :version_name
      t.string :version_code
      t.string :location
      t.string :source_ip
      t.text :fcm_token
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign
      t.string :utm_gclid

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
    add_index :users, :id
    add_index :users, :social_id
    add_index :users, :device_id    
    add_index :users, :utm_medium
    add_index :users, :advertising_id
    add_index :users, :referral_code
    add_index :users, :security_token
  end
end
