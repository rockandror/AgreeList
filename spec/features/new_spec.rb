require "spec_helper"

feature "new" do
  scenario "loads" do
    visit "/new"
    expect(page).to have_content("What's new")
  end
end
