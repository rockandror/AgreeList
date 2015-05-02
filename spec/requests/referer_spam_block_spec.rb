require "spec_helper"

describe "Referer blacklist", type: :request do
  before do
    9.times do
      create(:statement)
      create(:individual)
    end
  end
  describe "referer spam" do
    it "is blocked" do
      spammers = ["http://darodar.com", "http://theguardlan.com/"]

      spammers.each do |spammer|
        get root_path, {}, { "HTTP_REFERER" => spammer }

        expect(response).to be_forbidden
      end
    end
  end

  describe "regular referer" do
    it "is not blocked" do
      get root_path, {}, { "HTTP_REFERER" => "google.com" }

      expect(response).to be_ok
    end
  end

  describe "direct request" do
    it "is not blocked" do
      get root_path

      expect(response).to be_ok
    end
  end
end
