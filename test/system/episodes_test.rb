require "application_system_test_case"

class EpisodesTest < ApplicationSystemTestCase
  setup do
    @episode = episodes(:one)
  end

  test "visiting the index" do
    visit episodes_url
    assert_selector "h1", text: "Episodes"
  end

  test "should create episode" do
    visit episodes_url
    click_on "New episode"

    fill_in "Cast", with: @episode.cast
    fill_in "Content", with: @episode.content_id
    fill_in "Director", with: @episode.director
    fill_in "Runtime", with: @episode.runtime
    fill_in "Season", with: @episode.season
    check "Status" if @episode.status
    fill_in "Story", with: @episode.story
    fill_in "Thumbnail", with: @episode.thumbnail
    fill_in "Title", with: @episode.title
    fill_in "Url", with: @episode.url
    check "Vip status" if @episode.vip_status
    click_on "Create Episode"

    assert_text "Episode was successfully created"
    click_on "Back"
  end

  test "should update Episode" do
    visit episode_url(@episode)
    click_on "Edit this episode", match: :first

    fill_in "Cast", with: @episode.cast
    fill_in "Content", with: @episode.content_id
    fill_in "Director", with: @episode.director
    fill_in "Runtime", with: @episode.runtime
    fill_in "Season", with: @episode.season
    check "Status" if @episode.status
    fill_in "Story", with: @episode.story
    fill_in "Thumbnail", with: @episode.thumbnail
    fill_in "Title", with: @episode.title
    fill_in "Url", with: @episode.url
    check "Vip status" if @episode.vip_status
    click_on "Update Episode"

    assert_text "Episode was successfully updated"
    click_on "Back"
  end

  test "should destroy Episode" do
    visit episode_url(@episode)
    click_on "Destroy this episode", match: :first

    assert_text "Episode was successfully destroyed"
  end
end
