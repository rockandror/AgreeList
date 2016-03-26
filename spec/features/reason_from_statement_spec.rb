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
    click_button "Save"
    click_link "Why do you agree? Add a reason"
    fill_in :agreement_reason, with: "Because..."
    click_button "Save"
    expect(Agreement.last.reason).to eq "Because..."
  end
end
