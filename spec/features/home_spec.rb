require 'spec_helper'

feature 'next home' do
  before do
    6.times{ create(:statement) }
    create(:statement, content: "Should the UK remain a member of the EU?")
  end

  context "vote" do
    before do
      visit root_path
      click_link "Agree"
      fill_in "email", with: "hi@hectorperezarenas.com"
    end
    
    scenario 'should redirect to brexit' do
      click_button "See results"
      expect(page).to have_content("Should the UK remain a member of the EU?")
    end

    scenario "should save the email" do
      click_button "See results"
      expect(BetaEmail.last.email).to eq "hi@hectorperezarenas.com"
      expect(BetaEmail.last.comment).to eq "agree"
    end

    scenario "should send an email" do
      expect{ click_button "See results" }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
