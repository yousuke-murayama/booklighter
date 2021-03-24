class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :profile, presence: true, length: { maximum: 150 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    mount_uploader :image, ImageUploader
    
    has_many :rooms
    has_many :messages
    
    has_many :favorites
    has_many :like_messages, through: :favorites, source: :message, dependent: :destroy
    
    def add_favorite(message)
        self.favorites.find_or_create_by(message_id: message.id)
    end
    
    def unfavorite(message)
        favorite = self.favorites.find_by(message_id: message.id)
        favorite.destroy if favorite
    end
    
    def adding_favorite?(message)
        self.like_messages.include?(message)
    end
end
