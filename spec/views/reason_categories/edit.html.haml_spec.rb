require 'rails_helper'

RSpec.describe "reason_categories/edit", type: :view do
  before(:each) do
    @reason_category = assign(:reason_category, ReasonCategory.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit reason_category form" do
    render

    assert_select "form[action=?][method=?]", reason_category_path(@reason_category), "post" do

      assert_select "input#reason_category_name[name=?]", "reason_category[name]"
    end
  end
end
