class Work < ApplicationRecord
    validates :user_id, presence: true
    validates :image, presence: true
    validates :title, presence: true
    validates :description, presence: true
    validates :type_ids, presence: true
    
    belongs_to :user
    has_many :work_type_relations, dependent: :destroy
    has_many :types, through: :work_type_relations
    mount_uploader :image, ImageUploader
    
    # def save_works(savework_types)
    #     current_types = self.types.pluck(:work_type) unless self.types.nil?
    #     old_types = current_types - savework_types
    #     new_types = savework_types - current_types
        
    #     # 古いtypeを消去
    #     old_types.each do |old|
    #       self.types.delete Type.find_by(work_type: old) 
    #     end
        
    #     # typeを更新
    #     new_types.each do |new|
    #       new_work_type = Type.find_or_create_by(work_type: new)
    #       self.work_types << new_work_type
    #     end
    # end
end
