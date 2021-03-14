require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Format/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
