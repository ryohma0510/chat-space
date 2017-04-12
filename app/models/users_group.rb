class UsersGroup < ApplicationRecord
  #association
  belongs_to :user
  belongs_to :group

  #scope
  scope :registered, ->(group_id) { where(group_id: group_id).select(:user_id) }
end
