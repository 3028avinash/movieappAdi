class Coupon < ApplicationRecord
    def self.search(search)
        where("code LIKE ?", "%#{search}%") 
    end
end
