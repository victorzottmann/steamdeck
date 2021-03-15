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

  private

    def not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line items present")
        throw :abort
      end
    end
end
