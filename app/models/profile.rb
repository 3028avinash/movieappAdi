class Profile < ApplicationRecord
  belongs_to :user 
  has_one_attached :image

  validate :image_content_type

  def image_content_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:image, 'must be a JPEG, PNG, or GIF')
      image.purge
    end
  end

end
