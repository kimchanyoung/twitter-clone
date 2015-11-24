require 'rails_helper'

RSpec.describe "tweets/edit", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :content => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do

      assert_select "input#tweet_content[name=?]", "tweet[content]"

      assert_select "input#tweet_user_id[name=?]", "tweet[user_id]"
    end
  end
end
