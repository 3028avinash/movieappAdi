require "application_system_test_case"

class PlayTimesTest < ApplicationSystemTestCase
  setup do
    @play_time = play_times(:one)
  end

  test "visiting the index" do
    visit play_times_url
    assert_selector "h1", text: "Play times"
  end

  test "should create play time" do
    visit play_times_url
    click_on "New play time"

    fill_in "Episode", with: @play_time.episode_id
    fill_in "Time", with: @play_time.time
    fill_in "User", with: @play_time.user_id
    click_on "Create Play time"

    assert_text "Play time was successfully created"
    click_on "Back"
  end

  test "should update Play time" do
    visit play_time_url(@play_time)
    click_on "Edit this play time", match: :first

    fill_in "Episode", with: @play_time.episode_id
    fill_in "Time", with: @play_time.time
    fill_in "User", with: @play_time.user_id
    click_on "Update Play time"

    assert_text "Play time was successfully updated"
    click_on "Back"
  end

  test "should destroy Play time" do
    visit play_time_url(@play_time)
    click_on "Destroy this play time", match: :first

    assert_text "Play time was successfully destroyed"
  end
end
