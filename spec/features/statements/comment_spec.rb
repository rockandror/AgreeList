require 'spec_helper'

feature 'comment' do
  let(:individual) { create(:individual) }
  let(:statement) { create(:statement, content: "a single founder in a startup is a mistake") }

  before do
    create_home_page_stuff
  end

  context "logged in" do
    before do
      login
      visit statement_path(statement)
    end

    scenario 'new comment' do
      fill_in "comment_text", with: "Yep"
      click_button "Send"
      expect(page).to have_text("Your comment has been created")
    end
  end

  #scenario 'new' do
    #fill_in "comment_text", with: "Maybe not recommended but mistake sounds too extreme"
    #click_button "Send"
    #expect(page).to have_text("Your comment has been created")
    #expect(page).to have_text("Maybe not recommended but mistake sounds too extreme")
  #end

  #scenario 'wrong author' do
    #fill_in "comment_text", with: "Maybe not recommended but mistake sounds too extreme"
    #fill_in "twitter", with: "wrong"
    #click_button "Send"
    #expect(page).to have_text("be sure that the user @wrong exists on Twitter.")
  #end

  def create_home_page_stuff
    9.times{ create(:statement) }
  end

  def login
    visit 'auth/twitter'
  end
end
