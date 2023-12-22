class Content < ApplicationRecord
    has_many :episodes
    has_many :remiders, dependent: :destroy
    has_many :play_times, dependent: :destroy, foreign_key: :video_id


    def self.search(search)
        where("title LIKE ? OR category LIKE ? OR genre LIKE ? OR language LIKE ? OR release_date LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%") 
    end
end
