require 'rails_helper'

RSpec.describe "tweets/show", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :content => "Content",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/1/)
  end
end
