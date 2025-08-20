require "rails_helper"

RSpec.describe "Quests", type: :system do
  before do
    driven_by(:selenium_chrome)
  end
  setup do
    @quest = Quest.create!(name: "Sample todo")
  end
  it "visits the index" do
    visit quests_path
    expect(page).to have_selector("h1", text: "My Todo-list")
  end

  it "creates a quest" do
    visit quests_path

    within(first("main turbo-frame#new_quest_form")) do
      fill_in "quest_name", with: "My Quest"
      click_on "Create Quest"
    end

    within("turbo-frame#quests") do
      expect(page).to have_text("My Quest")
    end
  end

  it "creates and then destroys a quest" do
    visit quests_path

    # สร้าง quest ใหม่
    within(first("main turbo-frame#new_quest_form")) do
      fill_in "quest_name", with: "Temporary Quest"
      click_on "Create Quest"
    end

    # หา turbo-frame ของ quest ใหม่
    new_quest_frame = find("turbo-frame#quests").find("turbo-frame", text: "Temporary Quest")

    # ลบ quest และตรวจสอบว่า count ลดลง
    expect {
      within(new_quest_frame) do
        find("a[data-turbo-method='delete']").click
      end
      # รอให้ DOM update
      within("turbo-frame#quests") do
        expect(page).not_to have_text("Temporary Quest")
      end
    }.to change(Quest, :count).by(-1)
  end
end
