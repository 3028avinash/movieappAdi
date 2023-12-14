class User < ApplicationRecord
    has_many :appopens, :dependent => :destroy
end
