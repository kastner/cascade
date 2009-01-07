require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "should get categories" do
    get :new
    assert_template "new.html.erb"
    assert_not_nil assigns(:categories)
  end
end
