require 'rails_helper'

RSpec.describe "hashtags/edit", type: :view do
  before(:each) do
    @hashtag = assign(:hashtag, Hashtag.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit hashtag form" do
    render

    assert_select "form[action=?][method=?]", hashtag_path(@hashtag), "post" do

      assert_select "input#hashtag_name[name=?]", "hashtag[name]"
    end
  end
end
