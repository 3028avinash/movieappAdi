class Content < ApplicationRecord
    has_many :episodes

    def self.search(search)
        where("title LIKE ? OR category LIKE ? OR genre LIKE ? OR language LIKE ? OR release_date LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%") 
    end
end
