require 'rails_helper'

RSpec.describe "hashtags/new", type: :view do
  before(:each) do
    assign(:hashtag, Hashtag.new(
      :name => "MyString"
    ))
  end

  it "renders new hashtag form" do
    render

    assert_select "form[action=?][method=?]", hashtags_path, "post" do

      assert_select "input#hashtag_name[name=?]", "hashtag[name]"
    end
  end
end
