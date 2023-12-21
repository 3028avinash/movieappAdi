require "test_helper"

class HelpDesksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @help_desk = help_desks(:one)
  end

  test "should get index" do
    get help_desks_url
    assert_response :success
  end

  test "should get new" do
    get new_help_desk_url
    assert_response :success
  end

  test "should create help_desk" do
    assert_difference("HelpDesk.count") do
      post help_desks_url, params: { help_desk: { answer: @help_desk.answer, question: @help_desk.question, url: @help_desk.url } }
    end

    assert_redirected_to help_desk_url(HelpDesk.last)
  end

  test "should show help_desk" do
    get help_desk_url(@help_desk)
    assert_response :success
  end

  test "should get edit" do
    get edit_help_desk_url(@help_desk)
    assert_response :success
  end

  test "should update help_desk" do
    patch help_desk_url(@help_desk), params: { help_desk: { answer: @help_desk.answer, question: @help_desk.question, url: @help_desk.url } }
    assert_redirected_to help_desk_url(@help_desk)
  end

  test "should destroy help_desk" do
    assert_difference("HelpDesk.count", -1) do
      delete help_desk_url(@help_desk)
    end

    assert_redirected_to help_desks_url
  end
end
