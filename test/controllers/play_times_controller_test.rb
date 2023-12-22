require "test_helper"

class PlayTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @play_time = play_times(:one)
  end

  test "should get index" do
    get play_times_url
    assert_response :success
  end

  test "should get new" do
    get new_play_time_url
    assert_response :success
  end

  test "should create play_time" do
    assert_difference("PlayTime.count") do
      post play_times_url, params: { play_time: { episode_id: @play_time.episode_id, time: @play_time.time, user_id: @play_time.user_id } }
    end

    assert_redirected_to play_time_url(PlayTime.last)
  end

  test "should show play_time" do
    get play_time_url(@play_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_play_time_url(@play_time)
    assert_response :success
  end

  test "should update play_time" do
    patch play_time_url(@play_time), params: { play_time: { episode_id: @play_time.episode_id, time: @play_time.time, user_id: @play_time.user_id } }
    assert_redirected_to play_time_url(@play_time)
  end

  test "should destroy play_time" do
    assert_difference("PlayTime.count", -1) do
      delete play_time_url(@play_time)
    end

    assert_redirected_to play_times_url
  end
end
