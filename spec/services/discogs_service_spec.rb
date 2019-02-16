require 'rails_helper'

describe "Discogs Service" do
  context "can connect to Discogs API" do
    it "can return a non_authorized query" do
      conn = DiscogsService.conn
      response = conn.get "/"

      expect(response).to be_truthy
      expect(response.body[:hello]).to eq("Welcome to the Discogs API.")
    end
    it "can return an authorized query" do 
      response = DiscogsService.search("5099749994324", "barcode")
      expected = response.body[:results].first

      expect(expected[:title]).to eq("Cyndi Lauper - She's So Unusual") 
    end 
  end
end
