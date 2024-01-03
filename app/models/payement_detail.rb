class PayementDetail < ApplicationRecord
  belongs_to :user
  has_many :subscription_histories
end
