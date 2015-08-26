require 'spec_helper'

describe do
  before do
    seed_data
  end

  feature "homepage" do
    before do
      visit "/"
    end

    context "leave email" do
      before do
        fill_in "email", with: "hi@hectorperezarenas.com"
        fill_in "comment", with: "Hi"
      end

      scenario "send email" do
        expect(LogMailer).to receive(:log_email).with("email: hi@hectorperezarenas.com, comment: Hi").and_return( double("Mailer", :deliver => true))
        click_button "Send"
      end

      scenario "save email" do
        click_button "Send"
        expect(BetaEmail.first.email).to eq "hi@hectorperezarenas.com"
      end

      scenario "save comment" do
        click_button "Send"
        expect(BetaEmail.first.comment).to eq "Hi"
      end
    end

    scenario "should have a title h1" do
      expect(page).to have_selector('h1')
    end

    scenario "should have the contact email" do
      expect(page).to have_text("feedback@agreelist.com")
    end
  end

  private

  def seed_data
    create(:statement)
    create(:individual, twitter: "arpahector")
  end
end
