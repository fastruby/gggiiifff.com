require "spec_helper"
require "integration_helper"

RSpec.describe "Using the home page", type: :request do
  before do
    visit "/"
  end

  context "Visiting the home page" do
    it "shows me a search form" do
      expect(page).to have_content "Search all the gggiiifffs!"
    end
  end

  context "Searching for gifs" do
    context "and there are no results" do
      before do
        allow_any_instance_of(Gggiiifff::Query).to receive(:search!).and_return([])
      end

      it "changes the title based on my search term" do
        fill_in :q, with: "funny cats"
        click_button "Search"

        expect(page).to have_content "Search all the gggiiifffs for funny cats!"
        expect(page).to have_content "We didn't find any results! ¯\\_(ツ)_/¯"
      end
    end

    context "and there is one result" do
      let(:results) do
        File.read(File.join(File.dirname(__FILE__), "../support/cats.json"))
      end

      before do
        allow(RestClient).to receive(:get).and_return(results)
      end

      it "lists the results" do
        fill_in :q, with: "funny cats"
        click_button "Search"

        expect(page).to have_content "Search all the gggiiifffs for funny cats!"
        expect(page).not_to have_content "We didn't find any results! ¯\\_(ツ)_/¯"
      end
    end
  end
end
