class WorkTypeRelation < ApplicationRecord
  belongs_to :work
  belongs_to :type
  
  validates :work_id, presence: true
  validates :type_id, presence: true
end
