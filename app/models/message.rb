class Message < ApplicationRecord
    validates :content, presence: true, unless: :up_image
    
    belongs_to :user
    belongs_to :room, touch: true
    has_many :notifications,dependent: :destroy
    has_many_attached :images
    
    # def image
    #     self.images.variant(resize: '300×300').processed 
    # end
    private
    def up_image
        images.attached?
    end
end