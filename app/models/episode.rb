class Episode < ApplicationRecord
    belongs_to :content
    has_many :play_times, dependent: :destroy

    has_one_attached :file
    def self.search(search)
      where("title LIKE ? OR story LIKE ?", "%#{search}%", "%#{search}%")
    end
end
