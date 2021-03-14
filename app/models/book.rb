class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :user

  has_one_attached :picture

  enum condition: {damaged: 0, used: 1, good: 2, excellent: 3}

  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :publisher
end
