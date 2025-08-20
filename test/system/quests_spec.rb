require "rails_helper"

RSpec.describe "Quests", type: :system do
  let!(:quest) { Quest.create!(name: "Existing Quest") }

  before do
    driven_by(:selenium_chrome)
  end

  it "visits the index" do
    visit quests_path
    expect(page).to have_selector("h1", text: "My Todo-list")
  end

  it "creates a quest" do
    visit quests_path

    within("turbo-frame#new_quest_form") do
      fill_in "quest_name", with: "My Quest"   # ใช้ id ของ input field
      click_on "Create Quest"
    end

    within("turbo-frame#quests") do
      expect(page).to have_text("My Quest")
    end
  end

  it "destroys a quest" do
    visit quest_path(quest)

    accept_confirm do
      click_on "Destroy this quest", match: :first
    end

    expect(page).not_to have_text(quest.name)
  end
end
