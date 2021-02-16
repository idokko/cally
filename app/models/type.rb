class Type < ApplicationRecord
    has_many :work_type_relations,dependent: :destroy
    has_many :works, through: :work_type_relations, dependent: :destroy
end