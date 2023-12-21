require "application_system_test_case"

class HelpDesksTest < ApplicationSystemTestCase
  setup do
    @help_desk = help_desks(:one)
  end

  test "visiting the index" do
    visit help_desks_url
    assert_selector "h1", text: "Help desks"
  end

  test "should create help desk" do
    visit help_desks_url
    click_on "New help desk"

    fill_in "Answer", with: @help_desk.answer
    fill_in "Question", with: @help_desk.question
    click_on "Create Help desk"

    assert_text "Help desk was successfully created"
    click_on "Back"
  end

  test "should update Help desk" do
    visit help_desk_url(@help_desk)
    click_on "Edit this help desk", match: :first

    fill_in "Answer", with: @help_desk.answer
    fill_in "Question", with: @help_desk.question
    click_on "Update Help desk"

    assert_text "Help desk was successfully updated"
    click_on "Back"
  end

  test "should destroy Help desk" do
    visit help_desk_url(@help_desk)
    click_on "Destroy this help desk", match: :first

    assert_text "Help desk was successfully destroyed"
  end
end
