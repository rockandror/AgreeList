require 'spec_helper'

feature 'upvote', js: true do
  attr_reader :statement

  before do
    seed_data
  end

  context 'non logged user' do
    before do
      visit statement_path(statement)
    end

    scenario "should change text to Upvote (1)" do
      click_link "Agree"
      click_link "vote-twitter-login"
      expect(page).not_to have_content("Upvote (1)")
      expect{ click_link "Upvote" }.to change{ Upvote.count }.by(1)
      expect(page).to have_content("Upvote (1)")
    end

    context "when updating twice" do
      scenario "should destroy the upvote" do
        click_link "Agree"
        click_link "vote-twitter-login"
        click_link "Upvote"
        expect{ click_link "Upvote" }.to change{ Upvote.count }.by(-1)
      end
    end
  end

  private

  def seed_data
    @statement = create(:statement)
  end
end
