require 'spec_helper'

describe do
  before do
    Statement.create(content: "aaa")
    Individual.create(name: "bbbb", twitter: "ccc")
  end

  feature "title" do
    scenario "should have h1" do
      visit "/"
      expect(page).to have_selector('h1', text: '')
    end
  end

  feature "contact email" do
    scenario "should have contact email" do
      visit "/"
      click_on "Contact"
      expect(page).to have_text("feedback@agreelist.com")
    end
  end

  feature "create statement" do
    scenario "should create a statement" do
      visit "/"
      fill_in "question", with: "Should the UK leave the EU?"
      fill_in "email", with: "hi@hectorperezarenas.com"
      expect{ click_on "Create" }.to change{ Statement.count }.by(1)
    end

    scenario "should save the email of the author" do
      visit "/"
      fill_in "question", with: "Should the UK leave the EU?"
      fill_in "email", with: "hi@hectorperezarenas.com"
      expect{ click_on "Create" }.to change{ Individual.count }.by(1)
      expect(Individual.last.email).to eq "hi@hectorperezarenas.com"
    end
  end
end
