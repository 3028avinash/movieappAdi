class Episode < ApplicationRecord
    belongs_to :content
    def self.search(search)
        where("content_id LIKE ? OR title LIKE ?", "%#{search}%", "%#{search}%") 
    end
end
