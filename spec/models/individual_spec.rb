require 'spec_helper'

describe Individual do
  #let(:individual) { create(:individual) }

  subject { individual }

  it "create an individual" do
    expect{ create(:individual, twitter: "hector") }.to change{ Individual.count }.by(1)
  end

  it "doesn't allow to create two individuals with the same twitter" do
    create(:individual, twitter: "hector")
    expect{ create(:individual, twitter: "hector") }.to raise_error(/Twitter has already been taken/)
    expect(Individual.count).to eq 1
  end

  it "allow to create two individuals with twitter nil" do
    create(:individual, twitter: nil)
    create(:individual, twitter: nil)
    expect(Individual.count).to eq 2
  end

  it "saves blank twitter as nil" do
    individual = create(:individual, twitter: "")
    expect(individual.reload.twitter).to eq nil
  end
end
