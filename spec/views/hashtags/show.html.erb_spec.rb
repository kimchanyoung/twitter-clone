require 'rails_helper'

RSpec.describe "hashtags/show", type: :view do
  before(:each) do
    @hashtag = assign(:hashtag, Hashtag.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
