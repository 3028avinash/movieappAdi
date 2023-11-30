require "application_system_test_case"

class SubscriptionHistoriesTest < ApplicationSystemTestCase
  setup do
    @subscription_history = subscription_histories(:one)
  end

  test "visiting the index" do
    visit subscription_histories_url
    assert_selector "h1", text: "Subscription histories"
  end

  test "should create subscription history" do
    visit subscription_histories_url
    click_on "New subscription history"

    fill_in "Coupon", with: @subscription_history.coupon_id
    fill_in "Subscription end", with: @subscription_history.subscription_end
    fill_in "Subscription", with: @subscription_history.subscription_id
    fill_in "Subscription start", with: @subscription_history.subscription_start
    fill_in "User", with: @subscription_history.user_id
    click_on "Create Subscription history"

    assert_text "Subscription history was successfully created"
    click_on "Back"
  end

  test "should update Subscription history" do
    visit subscription_history_url(@subscription_history)
    click_on "Edit this subscription history", match: :first

    fill_in "Coupon", with: @subscription_history.coupon_id
    fill_in "Subscription end", with: @subscription_history.subscription_end
    fill_in "Subscription", with: @subscription_history.subscription_id
    fill_in "Subscription start", with: @subscription_history.subscription_start
    fill_in "User", with: @subscription_history.user_id
    click_on "Update Subscription history"

    assert_text "Subscription history was successfully updated"
    click_on "Back"
  end

  test "should destroy Subscription history" do
    visit subscription_history_url(@subscription_history)
    click_on "Destroy this subscription history", match: :first

    assert_text "Subscription history was successfully destroyed"
  end
end
