class PlayTime < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  validates :episode_id, uniqueness: { scope: :user_id, message: "can only be added once per user" }
end
