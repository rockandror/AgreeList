require 'spec_helper'

describe do
  before do
    seed_data
  end

  feature "about" do
    scenario "should have the contact email" do
      visit "/about"
      expect(page).to have_text("feedback@agreelist.com")
    end
  end

  feature "faq" do
    scenario "should have the contact email" do
      visit "/faq"
      expect(page).to have_text("feedback@agreelist.com")
    end
  end

  private

  def seed_data
    create(:statement)
    create(:individual, twitter: "arpahector")
  end
end
