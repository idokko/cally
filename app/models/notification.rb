class Notification < ApplicationRecord
    scope :recent, -> {order(created_at: :desc)}
    
    belongs_to :room
    belongs_to :messages
    
    belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end