require 'rails_helper'

RSpec.describe "hashtags/index", type: :view do
  before(:each) do
    assign(:hashtags, [
      Hashtag.create!(
        :name => "Name"
      ),
      Hashtag.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of hashtags" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
