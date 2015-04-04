require 'spec_helper'

feature 'disagree' do
  before do
    statement = create(:statement)
    login
    visit statement_path(statement)
  end

  scenario 'adds someone who disagrees' do
    choose 'add_disagreement'
    fill_in 'new_supporter', with: 'Superman'

    click_button "Add"
    expect(Agreement.last.disagree?).to eq(true)
  end

  def login
    Individual.create(name: "Hector", twitter: "arpahector")
    visit "/auth/twitter"
  end
end
