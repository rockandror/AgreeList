require 'spec_helper'

feature 'create statement from individual profile' do
  before do
    i = create(:individual, name: "Elon Musk", twitter: "elonmusk")
    s = create(:statement, individual: i)
    create(:agreement, statement: s, individual: i, extent: 100)
    visit "/auth/twitter"
  end

  scenario "should add the creator" do
    visit "/elonmusk"
    fill_in :content, with: "We should go to Mars"
    click_button "Add"
    expect(Statement.last.individual.name).to eq "Hector Perez"
  end
end
