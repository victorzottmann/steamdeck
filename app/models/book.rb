class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :user

  has_one_attached :picture
  has_many :line_items

  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :publisher

  resourcify
end
