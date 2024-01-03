require "application_system_test_case"

class PayementDetailsTest < ApplicationSystemTestCase
  setup do
    @payement_detail = payement_details(:one)
  end

  test "visiting the index" do
    visit payement_details_url
    assert_selector "h1", text: "Payement details"
  end

  test "should create payement detail" do
    visit payement_details_url
    click_on "New payement detail"

    fill_in "Amount", with: @payement_detail.amount
    fill_in "Order", with: @payement_detail.order_id
    fill_in "Payement", with: @payement_detail.payement_id
    fill_in "Subscription", with: @payement_detail.subscription_id
    fill_in "User", with: @payement_detail.user_id
    click_on "Create Payement detail"

    assert_text "Payement detail was successfully created"
    click_on "Back"
  end

  test "should update Payement detail" do
    visit payement_detail_url(@payement_detail)
    click_on "Edit this payement detail", match: :first

    fill_in "Amount", with: @payement_detail.amount
    fill_in "Order", with: @payement_detail.order_id
    fill_in "Payement", with: @payement_detail.payement_id
    fill_in "Subscription", with: @payement_detail.subscription_id
    fill_in "User", with: @payement_detail.user_id
    click_on "Update Payement detail"

    assert_text "Payement detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Payement detail" do
    visit payement_detail_url(@payement_detail)
    click_on "Destroy this payement detail", match: :first

    assert_text "Payement detail was successfully destroyed"
  end
end
