require 'spec_helper'

feature 'logged user' do
  before do
    statement = create(:statement)
    statement.tag_list = "entrepreneurship"
    statement.save
    login
    visit entrepreneurs_path
  end

  scenario 'adds someone who disagrees' do
    click_link "Disagree"
    #expect(Agreement.last.disagree?).to eq(true)
  end
end

def login
  Individual.create(name: "Hector", twitter: "arpahector")
  visit "/auth/twitter"
end

