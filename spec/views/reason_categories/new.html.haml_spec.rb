require 'rails_helper'

RSpec.describe "reason_categories/new", type: :view do
  before(:each) do
    assign(:reason_category, ReasonCategory.new(
      :name => "MyString"
    ))
  end

  it "renders new reason_category form" do
    render

    assert_select "form[action=?][method=?]", reason_categories_path, "post" do

      assert_select "input#reason_category_name[name=?]", "reason_category[name]"
    end
  end
end
