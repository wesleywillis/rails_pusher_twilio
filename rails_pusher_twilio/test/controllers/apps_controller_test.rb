require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  setup do
    @app = apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apps)
  end

  test "should create app" do
    assert_difference('App.count') do
      post :create, app: { from_number: @app.from_number, text: @app.text, timestamp: @app.timestamp }
    end

    assert_response 201
  end

  test "should show app" do
    get :show, id: @app
    assert_response :success
  end

  test "should update app" do
    put :update, id: @app, app: { from_number: @app.from_number, text: @app.text, timestamp: @app.timestamp }
    assert_response 204
  end

  test "should destroy app" do
    assert_difference('App.count', -1) do
      delete :destroy, id: @app
    end

    assert_response 204
  end
end
