class Group < ApplicationRecord
  #association
  has_many :users_groups
  has_many :users, through: :users_groups
  accepts_nested_attributes_for :users_groups, reject_if: proc { |attributes| attributes['user_id'].blank? }
  has_many :messages

  #validation
  validates :name, presence: true
end
