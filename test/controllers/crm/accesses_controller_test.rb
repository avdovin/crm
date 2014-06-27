require 'test_helper'

class Crm::AccessesControllerTest < ActionController::TestCase
  setup do
    @crm_access = crm_accesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crm_accesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crm_access" do
    assert_difference('Crm::Access.count') do
      post :create, crm_access: {  }
    end

    assert_redirected_to crm_access_path(assigns(:crm_access))
  end

  test "should show crm_access" do
    get :show, id: @crm_access
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crm_access
    assert_response :success
  end

  test "should update crm_access" do
    patch :update, id: @crm_access, crm_access: {  }
    assert_redirected_to crm_access_path(assigns(:crm_access))
  end

  test "should destroy crm_access" do
    assert_difference('Crm::Access.count', -1) do
      delete :destroy, id: @crm_access
    end

    assert_redirected_to crm_accesses_path
  end
end
