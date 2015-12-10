require 'spec_helper'

feature 'voting', js: true do
  before do
    s = Statement.create(content: "Is global warming real?")
    Agreement.create(individual: create(:individual), statement: s)
    visit root_path
  end

  scenario "should authenticate and agree" do
    click_link "Agree"
    click_link "vote-twitter-login"
    expect(page).to have_content("Hector Perez")
  end

  scenario "should authenticate and disagree" do
    click_link "Disagree"
    click_link "vote-twitter-login"
    expect(page).to have_content("Hector Perez")
  end

  context "logged in" do
    before do
      visit "/auth/twitter"
    end

    scenario "should vote" do
      click_link "Agree"
      expect(page).to have_content("Hector Perez")
    end

    scenario "should vote" do
      click_link "Disagree"
      expect(page).to have_content("Hector Perez")
    end
  end
end
 
