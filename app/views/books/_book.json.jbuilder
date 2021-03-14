json.extract! book, :id, :title, :description, :edition, :pages, :date, :format, :price, :quantity, :available, :author_id, :category_id, :publisher_id, :user_id, :created_at, :updated_at
json.url book_url(book, format: :json)
