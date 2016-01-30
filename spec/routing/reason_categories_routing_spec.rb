require "rails_helper"

RSpec.describe ReasonCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reason_categories").to route_to("reason_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/reason_categories/new").to route_to("reason_categories#new")
    end

    it "routes to #edit" do
      expect(:get => "/reason_categories/1/edit").to route_to("reason_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reason_categories").to route_to("reason_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reason_categories/1").to route_to("reason_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reason_categories/1").to route_to("reason_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reason_categories/1").to route_to("reason_categories#destroy", :id => "1")
    end

  end
end
