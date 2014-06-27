require 'test_helper'

class Crm::TasksControllerTest < ActionController::TestCase
  setup do
    @crm_task = crm_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crm_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crm_task" do
    assert_difference('Crm::Task.count') do
      post :create, crm_task: {  }
    end

    assert_redirected_to crm_task_path(assigns(:crm_task))
  end

  test "should show crm_task" do
    get :show, id: @crm_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crm_task
    assert_response :success
  end

  test "should update crm_task" do
    patch :update, id: @crm_task, crm_task: {  }
    assert_redirected_to crm_task_path(assigns(:crm_task))
  end

  test "should destroy crm_task" do
    assert_difference('Crm::Task.count', -1) do
      delete :destroy, id: @crm_task
    end

    assert_redirected_to crm_tasks_path
  end
end
