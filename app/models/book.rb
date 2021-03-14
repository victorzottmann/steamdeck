class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :user
end
