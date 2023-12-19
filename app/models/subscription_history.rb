class SubscriptionHistory < ApplicationRecord
    belongs_to :user
    belongs_to :subscription
    
    def self.search(search)
        where("user_id LIKE ? OR subscription_id LIKE ? OR coupon_id LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%") 
    end
end
