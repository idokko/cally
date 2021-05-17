class Cost < ApplicationRecord
    VALID_COST_REGEX = /\A[0-9]+\z/
    validates :price, presence: true, format: {with: VALID_COST_REGEX}
    
    belongs_to :user
    belongs_to :room
end
