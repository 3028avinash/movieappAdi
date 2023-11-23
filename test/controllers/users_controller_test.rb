require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { advertising_id: @user.advertising_id, device_id: @user.device_id, device_name: @user.device_name, device_type: @user.device_type, fcm_token: @user.fcm_token, location: @user.location, referral_code: @user.referral_code, security_token: @user.security_token, social_email: @user.social_email, social_id: @user.social_id, social_imgurl: @user.social_imgurl, social_name: @user.social_name, social_token: @user.social_token, social_type: @user.social_type, source_ip: @user.source_ip, utm_campaign: @user.utm_campaign, utm_content: @user.utm_content, utm_gclid: @user.utm_gclid, utm_medium: @user.utm_medium, utm_source: @user.utm_source, utm_term: @user.utm_term, version_code: @user.version_code, version_name: @user.version_name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { advertising_id: @user.advertising_id, device_id: @user.device_id, device_name: @user.device_name, device_type: @user.device_type, fcm_token: @user.fcm_token, location: @user.location, referral_code: @user.referral_code, security_token: @user.security_token, social_email: @user.social_email, social_id: @user.social_id, social_imgurl: @user.social_imgurl, social_name: @user.social_name, social_token: @user.social_token, social_type: @user.social_type, source_ip: @user.source_ip, utm_campaign: @user.utm_campaign, utm_content: @user.utm_content, utm_gclid: @user.utm_gclid, utm_medium: @user.utm_medium, utm_source: @user.utm_source, utm_term: @user.utm_term, version_code: @user.version_code, version_name: @user.version_name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
