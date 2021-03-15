class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_book(book)
    current_book = line_items.find_by(book_id: book.id)
    if current_book
      current_book.increment(:quantity)
    else
      current_book = line_items.build(book_id: book.id)
    end
    current_book
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price}
  end
end
