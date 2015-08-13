require 'spec_helper'

describe do
  before do
    seed_data
  end

  feature "homepage" do
    before do
      visit "/"
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
