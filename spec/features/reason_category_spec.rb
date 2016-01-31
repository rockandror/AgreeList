require 'spec_helper'

feature "reason categories", js: true do
  attr_reader :statement

  before do
    seed_data
  end

  context "non logged user" do
    before do
      login
      visit statement_path(statement)
    end

    scenario "should set a category" do
      click_link "Agree"
      click_link "vote-twitter-login"
      Agreement.last.update_attributes(reason: "blablabla")
      visit statement_path(statement)
      expect(Agreement.last.present?).to eq true
      select "Economy", from: "reason_category_from_agreement_#{Agreement.last.id}"
      expect(Agreement.last.reason_category.name).to eq "Economy"
    end
  end

  def seed_data
    @statement = create(:statement)
    ReasonCategory.create(name: "Economy")
    ReasonCategory.create(name: "Science")
  end

  def login
    visit "/auth/twitter"
  end
end
