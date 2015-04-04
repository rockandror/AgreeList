require 'spec_helper'

feature 'comment' do
  let(:individual) { create(:individual) }
  let(:statement) { create(:statement, content: "a single founder in a startup is a mistake") }

  before do
    create_home_page_stuff
    login
    visit statement_path(statement)
  end

  scenario 'show comment' do
    fill_in "comment_text", with: "Maybe not recommended but mistake sounds too extreme"
    click_button "Send"
    expect(page).to have_text("Your comment has been created")
    expect(page).to have_text("Maybe not recommended but mistake sounds too extreme")
  end

  def create_home_page_stuff
    9.times{ create(:statement) }
  end

  def login
    visit 'auth/twitter'
  end
end
