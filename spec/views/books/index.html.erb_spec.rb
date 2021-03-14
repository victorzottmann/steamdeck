require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        title: "Title",
        description: "MyText",
        edition: 2,
        pages: 3,
        format: "Format",
        price: 4,
        quantity: 5,
        available: false,
        author: nil,
        category: nil,
        publisher: nil,
        user: nil
      ),
      Book.create!(
        title: "Title",
        description: "MyText",
        edition: 2,
        pages: 3,
        format: "Format",
        price: 4,
        quantity: 5,
        available: false,
        author: nil,
        category: nil,
        publisher: nil,
        user: nil
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Format".to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
