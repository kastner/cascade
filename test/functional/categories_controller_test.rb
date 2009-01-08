require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category1 = Category.create(:name => "Books")
    @category2 = Category.create(:parent => @category1, :name => "Non Fiction")
  end
  
  test "show should return a list of children" do
    get :show, :id => @category1.id, :format => 'js'
    assert_not_nil assigns(:categories)
    assert assigns(:categories).include?(@category2)
  end
  
  test "should allow a new category" do
    post :create, :category => { :name => "New Test Category" }
    assert_response :ok
  end
  
  test "should not allow a new category with an exsiting name" do
    Category.create(:name => "Something")
    
    post :create, :category => { :name => "Something" }
    assert_response :bad_request
  end
end
