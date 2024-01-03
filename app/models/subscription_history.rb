class SubscriptionHistory < ApplicationRecord
    belongs_to :user
    belongs_to :subscription
    belongs_to :payement_details

    validate :only_one_active_subscription_per_user, on: [:create, :update]

    def only_one_active_subscription_per_user
        if self.status == 'active' && SubscriptionHistory.where.not(id: self.id).exists?(user_id: self.user_id, status: 'active')
        errors.add(:base, 'User already has an active subscription')
        end
    end

    def self.search(search)
        where("user_id LIKE ? OR subscription_id LIKE ? OR coupon_id LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%") 
    end


end
