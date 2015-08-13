require 'spec_helper'

feature 'join' do
  before do
    seed_data
    login
  end

  scenario 'redirect_to statement' do
    expect(current_path).to eq("/entrepreneurs")
  end

  private

  def seed_data
    create(:statement)
    create(:individual, twitter: "arpahector")
  end

  def login
    visit "/auth/twitter"
  end
end
