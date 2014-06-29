require 'test_helper'

class Crm::UsersControllerTest < ActionController::TestCase
  setup do
    @crm_user = crm_users(:one)
  end

  test "should get index" do
    setup

    get :index
    assert_response :success
    assert_not_nil assigns(:crm_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crm_user" do
    assert_difference('Crm::User.count') do
      post :create, crm_user: { email: @crm_user.email, nickname: @crm_user.nickname, password_digest: @crm_user.password_digest }
    end

    assert_redirected_to crm_user_path(assigns(:crm_user))
  end

  test "should get edit" do
    get :edit, id: @crm_user
    assert_response :success
  end

  test "should update crm_user" do
    patch :update, id: @crm_user, crm_user: { email: @crm_user.email, nickname: @crm_user.nickname, password_digest: @crm_user.password_digest }
    assert_redirected_to crm_user_path(assigns(:crm_user))
  end

  test "should destroy crm_user" do
    assert_difference('Crm::User.count', -1) do
      delete :destroy, id: @crm_user
    end

    assert_redirected_to crm_users_path
  end
end
