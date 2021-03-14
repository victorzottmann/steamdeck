require 'rails_helper'

RSpec.describe "publishers/new", type: :view do
  before(:each) do
    assign(:publisher, Publisher.new(
      name: "MyString"
    ))
  end

  it "renders new publisher form" do
    render

    assert_select "form[action=?][method=?]", publishers_path, "post" do

      assert_select "input[name=?]", "publisher[name]"
    end
  end
end
