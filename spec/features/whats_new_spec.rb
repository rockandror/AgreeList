require 'spec_helper'

feature "What's new" do
  before do
    @statement = create(:statement)
    5.times do
      individual = create(:individual)
      Agreement.create(individual: individual, statement: @statement, extent: 100)
    end
  end

  scenario "loads page" do
    visit statement_path(@statement)
    click_link "Votes"
    expect(page).to have_link "Date"
    click_link "Date"
    expect(page).to have_link "Votes"
  end
end
