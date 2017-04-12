class Message < ApplicationRecord
  #association
  belongs_to :group
  belongs_to :user
end
