class Room < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  has_many :messages
  has_many :users, through: :messages
end
