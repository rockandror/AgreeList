require 'spec_helper'

feature 'reason', js: true do
  before do
    @statement = create(:statement)
    @individual = create(:individual)
 end

  scenario 'should be updated' do
    visit statement_path(@statement)
    click_link "Agree"
    click_link "vote-twitter-login"
    fill_in :agreement_reason, with: "Because..."
    click_button "Save"
    expect(page).to have_content("Because...")
    expect(Agreement.last.reason).to eq "Because..."
  end
end
