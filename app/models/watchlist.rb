class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :user_id, uniqueness: { scope: :episode_id, message: 'You can only Add a Episode once' }
end
