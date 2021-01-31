class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 15}
    validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/}
    validates :password, length: {in: 8..20}, format: {with: /\A(?=.*?[a-z])(?=.*\d)[a-z\d]{1,}\z/}
    
    has_secure_password
end
