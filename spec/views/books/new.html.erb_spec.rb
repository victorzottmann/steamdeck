require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      title: "MyString",
      description: "MyText",
      edition: 1,
      pages: 1,
      format: "MyString",
      price: 1,
      quantity: 1,
      available: false,
      author: nil,
      category: nil,
      publisher: nil,
      user: nil
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[title]"

      assert_select "textarea[name=?]", "book[description]"

      assert_select "input[name=?]", "book[edition]"

      assert_select "input[name=?]", "book[pages]"

      assert_select "input[name=?]", "book[format]"

      assert_select "input[name=?]", "book[price]"

      assert_select "input[name=?]", "book[quantity]"

      assert_select "input[name=?]", "book[available]"

      assert_select "input[name=?]", "book[author_id]"

      assert_select "input[name=?]", "book[category_id]"

      assert_select "input[name=?]", "book[publisher_id]"

      assert_select "input[name=?]", "book[user_id]"
    end
  end
end
