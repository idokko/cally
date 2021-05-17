class Room < ApplicationRecord
    has_many :entries, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :users, through: :entries
    has_many :notifications, dependent: :destroy
    has_many :visitors, through: :notifications
    has_many :costs, dependent: :destroy
end