class Work < ApplicationRecord
    validates :user_id, presence: true
    validates :title, presence: true
    validates :description, presence: true
    # validates :type_ids => [], presence: true
    validates :image, presence: true
    
    belongs_to :user
    has_many :work_type_relations, dependent: :destroy
    has_many :types, through: :work_type_relations
    mount_uploader :image, ImageUploader
end
