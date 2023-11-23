require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url
    click_on "New user"

    fill_in "Advertising", with: @user.advertising_id
    fill_in "Device", with: @user.device_id
    fill_in "Device name", with: @user.device_name
    fill_in "Device type", with: @user.device_type
    fill_in "Fcm token", with: @user.fcm_token
    fill_in "Location", with: @user.location
    fill_in "Referral code", with: @user.referral_code
    fill_in "Security token", with: @user.security_token
    fill_in "Social email", with: @user.social_email
    fill_in "Social", with: @user.social_id
    fill_in "Social imgurl", with: @user.social_imgurl
    fill_in "Social name", with: @user.social_name
    fill_in "Social token", with: @user.social_token
    fill_in "Social type", with: @user.social_type
    fill_in "Source ip", with: @user.source_ip
    fill_in "Utm campaign", with: @user.utm_campaign
    fill_in "Utm content", with: @user.utm_content
    fill_in "Utm gclid", with: @user.utm_gclid
    fill_in "Utm medium", with: @user.utm_medium
    fill_in "Utm source", with: @user.utm_source
    fill_in "Utm term", with: @user.utm_term
    fill_in "Version code", with: @user.version_code
    fill_in "Version name", with: @user.version_name
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "should update User" do
    visit user_url(@user)
    click_on "Edit this user", match: :first

    fill_in "Advertising", with: @user.advertising_id
    fill_in "Device", with: @user.device_id
    fill_in "Device name", with: @user.device_name
    fill_in "Device type", with: @user.device_type
    fill_in "Fcm token", with: @user.fcm_token
    fill_in "Location", with: @user.location
    fill_in "Referral code", with: @user.referral_code
    fill_in "Security token", with: @user.security_token
    fill_in "Social email", with: @user.social_email
    fill_in "Social", with: @user.social_id
    fill_in "Social imgurl", with: @user.social_imgurl
    fill_in "Social name", with: @user.social_name
    fill_in "Social token", with: @user.social_token
    fill_in "Social type", with: @user.social_type
    fill_in "Source ip", with: @user.source_ip
    fill_in "Utm campaign", with: @user.utm_campaign
    fill_in "Utm content", with: @user.utm_content
    fill_in "Utm gclid", with: @user.utm_gclid
    fill_in "Utm medium", with: @user.utm_medium
    fill_in "Utm source", with: @user.utm_source
    fill_in "Utm term", with: @user.utm_term
    fill_in "Version code", with: @user.version_code
    fill_in "Version name", with: @user.version_name
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "should destroy User" do
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end
