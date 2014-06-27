require 'test_helper'

class Crm::DomainsControllerTest < ActionController::TestCase
  setup do
    @crm_domain = crm_domains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crm_domains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crm_domain" do
    assert_difference('Crm::Domain.count') do
      post :create, crm_domain: {  }
    end

    assert_redirected_to crm_domain_path(assigns(:crm_domain))
  end

  test "should show crm_domain" do
    get :show, id: @crm_domain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crm_domain
    assert_response :success
  end

  test "should update crm_domain" do
    patch :update, id: @crm_domain, crm_domain: {  }
    assert_redirected_to crm_domain_path(assigns(:crm_domain))
  end

  test "should destroy crm_domain" do
    assert_difference('Crm::Domain.count', -1) do
      delete :destroy, id: @crm_domain
    end

    assert_redirected_to crm_domains_path
  end
end
