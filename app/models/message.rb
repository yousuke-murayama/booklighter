class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  has_many :favorites
  has_many :users, through: :favorites 
  
  validates :content, presence: true, length: { maximum: 255 }
end
