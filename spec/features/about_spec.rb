require 'spec_helper'

describe do
  before do
    seed_data
  end

  feature "about" do
    before do
      visit "/about"
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
