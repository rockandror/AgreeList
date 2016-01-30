require 'rails_helper'

RSpec.describe "reason_categories/index", type: :view do
  before(:each) do
    assign(:reason_categories, [
      ReasonCategory.create!(
        :name => "Name"
      ),
      ReasonCategory.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of reason_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
