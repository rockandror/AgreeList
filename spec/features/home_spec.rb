require 'spec_helper'

feature 'voting', js: true do
  before do
    @statement = Statement.create(content: "Is global warming real?")
    Agreement.create(individual: create(:individual), statement: @statement)
    visit root_path
  end

  scenario "should authenticate and agree" do
    click_link "Yes, I agree"
    click_link "vote-twitter-login"
    expect(page).to have_content("Why do you agree on brexit?")
    fill_in :agreement_reason, with: "Because it's good for the economy"
    click_button "See results"
    visit statement_path(@statement)
    expect(page).to have_content("Hector Perez")
    expect(page).to have_content("Because it's good for the economy")
  end

  scenario "should authenticate and disagree" do
    click_link "No, I disagree"
    click_link "vote-twitter-login"
    expect(page).to have_content("Why do you disagree on brexit?")
    fill_in :agreement_reason, with: "Because it's bad for the economy"
    click_button "See results"
    visit statement_path(@statement)
    expect(page).to have_content("Hector Perez")
    expect(page).to have_content("Because it's bad for the economy")
  end

  context "logged in" do
    before do
      visit "/auth/twitter"
    end

    scenario "should vote" do
      click_link "Yes, I agree"
      expect(page).to have_content("Why do you agree on brexit?")
      fill_in :agreement_reason, with: "Because it's bad for the economy"
      click_button "See results"
      visit statement_path(@statement)
      expect(page).to have_content("Hector Perez")
      expect(page).to have_content("Because it's bad for the economy")
    end

    scenario "should vote" do
      click_link "No, I disagree"
      expect(page).to have_content("Why do you disagree on brexit?")
      fill_in :agreement_reason, with: "Because it's bad for the economy"
      click_button "See results"
      visit statement_path(@statement)
      expect(page).to have_content("Hector Perez")
      expect(page).to have_content("Because it's bad for the economy")
    end
  end
end
 
