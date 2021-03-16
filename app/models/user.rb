class User < ApplicationRecord
  rolify

  has_many :books, dependent: :destroy
  has_one_attached :profile_picture

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :first_name, length: { within: 1..20, too_long: "%{count} characters is the maximum allowed" }
         validates :last_name, length: { within: 1..20, too_long: "%{count} characters is the maximum allowed" }
         validates :username, uniqueness: true, length: { within: 1..15, too_long: "%{count} characters is the maximum allowed" }
         validates :email, presence: true, uniqueness: true
         validates :bio, length: { maximum: 200, too_long: "200 characters is the maximum allowed" }
         validates :password, length: { in: 6..20, too_long: "%{count} characters is the maximum allowed" }
end
