require "test_helper"

class AppopensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appopen = appopens(:one)
  end

  test "should get index" do
    get appopens_url
    assert_response :success
  end

  test "should get new" do
    get new_appopen_url
    assert_response :success
  end

  test "should create appopen" do
    assert_difference("Appopen.count") do
      post appopens_url, params: { appopen: { location: @appopen.location, source_ip: @appopen.source_ip, user_id: @appopen.user_id, version_code: @appopen.version_code, version_name: @appopen.version_name } }
    end

    assert_redirected_to appopen_url(Appopen.last)
  end

  test "should show appopen" do
    get appopen_url(@appopen)
    assert_response :success
  end

  test "should get edit" do
    get edit_appopen_url(@appopen)
    assert_response :success
  end

  test "should update appopen" do
    patch appopen_url(@appopen), params: { appopen: { location: @appopen.location, source_ip: @appopen.source_ip, user_id: @appopen.user_id, version_code: @appopen.version_code, version_name: @appopen.version_name } }
    assert_redirected_to appopen_url(@appopen)
  end

  test "should destroy appopen" do
    assert_difference("Appopen.count", -1) do
      delete appopen_url(@appopen)
    end

    assert_redirected_to appopens_url
  end
end
