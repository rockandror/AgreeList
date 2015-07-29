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

  scenario 'adds someone who disagrees with its twitter' do
    fill_in 'name', with: "@arpahector"
    click_button "Disagree"
    expect(Individual.last.twitter).to eq "arpahector"
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
  
  scenario 'comment' do
    fill_in 'name', with: 'Superman'
    fill_in 'comment', with: 'Because...'

    click_button "Disagree"
    expect(Comment.last.text).to eq "Because..."

  end

  scenario 'should create two users when adding someone else' do
    fill_in 'name', with: 'Superman'
    fill_in 'source', with: 'http://...'
    fill_in 'email', with: 'hhh@jjj.com'

    expect{ click_button "Agree" }.to change{ Individual.count }.by(2)
  end

  scenario 'adds someone who disagrees with its twitter' do
    fill_in 'name', with: "@arpahector"
    click_button "Disagree"
    expect(Individual.last.twitter).to eq "arpahector"
  end

  scenario 'adds two times the same @user' do
    fill_in 'name', with: "@arpahector"
    click_button "Agree"
    fill_in 'name', with: "@arpahector"
    click_button "Agree"
    expect(Individual.count).to eq 1
  end
end

def login
  Individual.create(name: "Hector", twitter: "arpahector")
  visit "/auth/twitter"
end

