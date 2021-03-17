class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :profile, presence: true, length: { maximum: 150 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :rooms
end
