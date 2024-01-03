require "test_helper"

class PayementDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payement_detail = payement_details(:one)
  end

  test "should get index" do
    get payement_details_url
    assert_response :success
  end

  test "should get new" do
    get new_payement_detail_url
    assert_response :success
  end

  test "should create payement_detail" do
    assert_difference("PayementDetail.count") do
      post payement_details_url, params: { payement_detail: { amount: @payement_detail.amount, order_id: @payement_detail.order_id, payement_id: @payement_detail.payement_id, subscription_id: @payement_detail.subscription_id, user_id: @payement_detail.user_id } }
    end

    assert_redirected_to payement_detail_url(PayementDetail.last)
  end

  test "should show payement_detail" do
    get payement_detail_url(@payement_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_payement_detail_url(@payement_detail)
    assert_response :success
  end

  test "should update payement_detail" do
    patch payement_detail_url(@payement_detail), params: { payement_detail: { amount: @payement_detail.amount, order_id: @payement_detail.order_id, payement_id: @payement_detail.payement_id, subscription_id: @payement_detail.subscription_id, user_id: @payement_detail.user_id } }
    assert_redirected_to payement_detail_url(@payement_detail)
  end

  test "should destroy payement_detail" do
    assert_difference("PayementDetail.count", -1) do
      delete payement_detail_url(@payement_detail)
    end

    assert_redirected_to payement_details_url
  end
end
