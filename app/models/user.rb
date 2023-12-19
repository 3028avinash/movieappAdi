class User < ApplicationRecord
    has_many :appopens, :dependent => :destroy
    has_many :subscription_histories, :dependent => :destroy
end
