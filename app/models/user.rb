class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validation
  validates :name, presence: true, length: { maximum: 6 }

  #association
  has_many :users_groups
  has_many :groups, through: :users_groups
  has_many :messages
end
