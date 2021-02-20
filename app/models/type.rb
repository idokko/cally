class Type < ApplicationRecord
    has_many :work_type_relations,dependent: :destroy, foreign_key: 'type_id'
    has_many :works, through: :work_type_relations, dependent: :destroy
end