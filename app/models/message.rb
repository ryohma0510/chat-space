class Message < ApplicationRecord
  #association
  belongs_to :group
  belongs_to :user

  #validation
  validates :content, presence: true
end
