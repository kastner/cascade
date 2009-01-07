require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category1 = Category.create(:name => "Books")
    @category2 = Category.create(:parent => @category1, :name => "Non Fiction")
  end
  
  test "show should return a list of children" do
    get :show, :id => @category1.id, :format => 'js'
    assert_template 'show.js.rjs'
    assert_not_nil assigns(:children)
  end
end
