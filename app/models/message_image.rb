class MessageImage < ApplicationRecord
    belongs_to :message
    
    mount_uploader :photos, ImageUploader
end
