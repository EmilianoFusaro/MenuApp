require 'test_helper'

class ReceivesControllerTest < ActionController::TestCase
  setup do
    @receife = receives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:receives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create receife" do
    assert_difference('Receive.count') do
      post :create, receife: { email: @receife.email, messaggio: @receife.messaggio, nome: @receife.nome, oggetto: @receife.oggetto, tipo: @receife.tipo }
    end

    assert_redirected_to receife_path(assigns(:receife))
  end

  test "should show receife" do
    get :show, id: @receife
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @receife
    assert_response :success
  end

  test "should update receife" do
    patch :update, id: @receife, receife: { email: @receife.email, messaggio: @receife.messaggio, nome: @receife.nome, oggetto: @receife.oggetto, tipo: @receife.tipo }
    assert_redirected_to receife_path(assigns(:receife))
  end

  test "should destroy receife" do
    assert_difference('Receive.count', -1) do
      delete :destroy, id: @receife
    end

    assert_redirected_to receives_path
  end
end
