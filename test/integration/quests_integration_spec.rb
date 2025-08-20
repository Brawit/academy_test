# spec/system/quests_spec.rb
require "rails_helper"

RSpec.describe "Quests", type: :system do
  let!(:quest) { Quest.create!(name: "Existing Quest", is_done: false) }

  before do
    driven_by(:selenium_chrome) # เปิด browser GUI
  end

  it "creates a quest" do
    visit quests_path

    within("turbo-frame#new_quest_form") do
      fill_in "quest_name", with: "My Quest"  # ใช้ id ของ input
      click_on "Create Quest"
    end

    # ตรวจสอบว่า quest แสดงใน frame quests
    within("turbo-frame#quests") do
      expect(page).to have_text("My Quest")
    end
  end


  it "marks a quest as finished" do
    visit quests_path

    within("turbo-frame#quest_#{quest.id}") do
      check "Is done" # label ของ checkbox ถูกต้อง
    end

    # ตรวจสอบ strike-through class
    expect(page).to have_css("span.line-through", text: quest.name)

    quest.reload
    expect(quest.is_done).to be true
  end

  it "destroys a quest" do
    visit quest_path(quest)

    accept_confirm do
      click_on "Destroy this quest", match: :first
    end

    expect(page).not_to have_text(quest.name)
  end
end
