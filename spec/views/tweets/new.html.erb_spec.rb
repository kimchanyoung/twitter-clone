require 'rails_helper'

RSpec.describe "tweets/new", type: :view do
  before(:each) do
    assign(:tweet, Tweet.new(
      :content => "MyString",
      :user_id => 1
    ))
  end

  it "renders new tweet form" do
    render

    assert_select "form[action=?][method=?]", tweets_path, "post" do

      assert_select "input#tweet_content[name=?]", "tweet[content]"

      assert_select "input#tweet_user_id[name=?]", "tweet[user_id]"
    end
  end
end
