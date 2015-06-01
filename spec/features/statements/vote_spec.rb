require 'spec_helper'

feature 'logged user' do
  before do
    statement = create(:statement)
    login
    visit statement_path(statement)
  end

  scenario 'adds someone who disagrees' do
    fill_in 'name', with: 'Superman'

    click_button "Disagree"
    expect(Agreement.last.disagree?).to eq(true)
  end
end


feature 'non logged user' do
  before do
    statement = create(:statement)
    visit statement_path(statement)
  end

  scenario 'adds someone who disagrees' do
    fill_in 'name', with: 'Superman'

    click_button "Disagree"
    expect(Agreement.last.disagree?).to eq(true)
  end

  scenario 'should create two users when adding someone else' do
    fill_in 'name', with: 'Superman'
    fill_in 'source', with: 'http://...'

    expect{ click_button "Agree" }.to change{ Individual.count }.by(2)
  end
end

def login
  Individual.create(name: "Hector", twitter: "arpahector")
  visit "/auth/twitter"
end

