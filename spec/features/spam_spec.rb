require 'spec_helper'

feature 'spam filter' do
  let(:statement) { create(:statement) }
  let(:individual) { create(:individual) }

  scenario 'should filter names without surname' do
    # real people have name and surname separated by a space
    visit statement_path(statement)
    fill_in 'name', with: "Spammer"
    click_button "Agree"
    expect(page).to have_text "Your message has to be approved because it seemed spam."
  end
end
