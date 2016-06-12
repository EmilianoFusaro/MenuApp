require 'test_helper'

class AllergensControllerTest < ActionController::TestCase
  setup do
    @allergen = allergens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allergens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allergen" do
    assert_difference('Allergen.count') do
      post :create, allergen: { descrizione: @allergen.descrizione, img1: @allergen.img1, img2: @allergen.img2, img: @allergen.img, nome: @allergen.nome }
    end

    assert_redirected_to allergen_path(assigns(:allergen))
  end

  test "should show allergen" do
    get :show, id: @allergen
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allergen
    assert_response :success
  end

  test "should update allergen" do
    patch :update, id: @allergen, allergen: { descrizione: @allergen.descrizione, img1: @allergen.img1, img2: @allergen.img2, img: @allergen.img, nome: @allergen.nome }
    assert_redirected_to allergen_path(assigns(:allergen))
  end

  test "should destroy allergen" do
    assert_difference('Allergen.count', -1) do
      delete :destroy, id: @allergen
    end

    assert_redirected_to allergens_path
  end
end
