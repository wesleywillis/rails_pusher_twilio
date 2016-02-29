require 'test_helper'

class SmsControllerTest < ActionController::TestCase
  setup do
    @sm = sms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms)
  end

  test "should create sm" do
    assert_difference('Sm.count') do
      post :create, sm: { from_number: @sm.from_number, text: @sm.text, timestamp: @sm.timestamp }
    end

    assert_response 201
  end

  test "should show sm" do
    get :show, id: @sm
    assert_response :success
  end

  test "should update sm" do
    put :update, id: @sm, sm: { from_number: @sm.from_number, text: @sm.text, timestamp: @sm.timestamp }
    assert_response 204
  end

  test "should destroy sm" do
    assert_difference('Sm.count', -1) do
      delete :destroy, id: @sm
    end

    assert_response 204
  end
end
