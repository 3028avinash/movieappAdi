class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :release_date
      t.string :genre
      t.string :category
      t.string :banner
      t.string :trailer_link
      t.boolean :is_slider, default:false
      t.boolean :vip_status, default:true
      t.boolean :status, default:false
      t.integer :views

      t.timestamps
    end
  end
end
