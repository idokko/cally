class Message < ApplicationRecord
    validates :content, presence: true
    
    belongs_to :user
    belongs_to :room, touch: true
    has_many :notifications,dependent: :destroy
end