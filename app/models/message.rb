class Message < ApplicationRecord
  #association
  belongs_to :group
  belongs_to :user

  #validation
  validates :content, :user_id, :group_id, presence: true, if: 'image.blank?'

  #carrierwave
  mount_uploader :image, ImagesUploader
end
