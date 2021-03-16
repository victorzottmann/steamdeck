class Book < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item

  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  belongs_to :user

  has_one_attached :picture
  has_many :line_items

  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :publisher

  resourcify

  validates :title, presence: true
  validates :description, length: { maximum: 500 }
  validates :format, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters are allowed"}
  validates :edition, :pages, :price, :quantity, numericality: { only_integer: true }

  private

    def not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "You have this book added to your cart.")
        throw :abort
      end
    end
end
