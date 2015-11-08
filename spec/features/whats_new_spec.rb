require 'spec_helper'

feature "What's new" do
  before do
    @statement = create(:statement)
  end

  scenario "loads page" do
    visit statement_path(@statement)
    click_link "Change to What's new"
    expect(page).to have_link "Change to Ranking"
    click_link "Change to Ranking"
    expect(page).to have_link "Change to What's new"
  end
end
