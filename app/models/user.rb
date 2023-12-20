class User < ApplicationRecord
    has_many :appopens, :dependent => :destroy
    has_one :profile, :dependent => :destroy
    has_many :subscription_histories, :dependent => :destroy

    after_create :profile_create

    private
        def profile_create
            self.create_profile(name: self.social_name, mobile: self.mobile_number)
        end
end
