class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.integer :content_id
      t.integer :season
      t.string :url
      t.string :thumbnail
      t.string :title
      t.string :runtime
      t.string :cast
      t.string :director
      t.text :story
      t.boolean :vip_status, default:true
      t.boolean :status, default:false

      t.timestamps
    end
  end
end
