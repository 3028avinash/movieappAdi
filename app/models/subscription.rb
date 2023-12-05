class Subscription < ApplicationRecord
    def self.search(search)
        where("name LIKE ? OR real_amount LIKE ? OR offer_amount LIKE ? OR duration LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
    end
end
