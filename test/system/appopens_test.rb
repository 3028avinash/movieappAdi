require "application_system_test_case"

class AppopensTest < ApplicationSystemTestCase
  setup do
    @appopen = appopens(:one)
  end

  test "visiting the index" do
    visit appopens_url
    assert_selector "h1", text: "Appopens"
  end

  test "should create appopen" do
    visit appopens_url
    click_on "New appopen"

    fill_in "Location", with: @appopen.location
    fill_in "Source ip", with: @appopen.source_ip
    fill_in "User", with: @appopen.user_id
    fill_in "Version code", with: @appopen.version_code
    fill_in "Version name", with: @appopen.version_name
    click_on "Create Appopen"

    assert_text "Appopen was successfully created"
    click_on "Back"
  end

  test "should update Appopen" do
    visit appopen_url(@appopen)
    click_on "Edit this appopen", match: :first

    fill_in "Location", with: @appopen.location
    fill_in "Source ip", with: @appopen.source_ip
    fill_in "User", with: @appopen.user_id
    fill_in "Version code", with: @appopen.version_code
    fill_in "Version name", with: @appopen.version_name
    click_on "Update Appopen"

    assert_text "Appopen was successfully updated"
    click_on "Back"
  end

  test "should destroy Appopen" do
    visit appopen_url(@appopen)
    click_on "Destroy this appopen", match: :first

    assert_text "Appopen was successfully destroyed"
  end
end
