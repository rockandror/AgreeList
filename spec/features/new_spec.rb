require "spec_helper"

feature "new" do
  scenario "loads" do
    visit root_path
    expect(page).to have_content("Discover new opinions")
  end
end
