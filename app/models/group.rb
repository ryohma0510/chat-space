class Group < ApplicationRecord
  #association
  has_many :users_groups
  has_many :users, through: :users_groups
  accepts_nested_attributes_for :users_groups
end
