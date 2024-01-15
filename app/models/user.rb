class User < ApplicationRecord
  has_many :appopens, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :subscription_histories, :dependent => :destroy
  has_many :remiders, dependent: :destroy
  has_many :play_times, dependent: :destroy
  has_many :payement_details, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :favorite_lists, dependent: :destroy
  has_many :queries, dependent: :destroy

  after_create :profile_create

  private
    def profile_create
      self.create_profile(name: self.social_name, mobile: self.mobile_number)
    end
end
