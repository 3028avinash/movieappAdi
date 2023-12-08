class Episode < ApplicationRecord
    belongs_to :content
    has_one_attached :file
    def self.search(search)
        where("content_id LIKE ? OR title LIKE ?", "%#{search}%", "%#{search}%") 
    end
end
