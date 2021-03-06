require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category1 = Category.create(:name => "Books")
    @category2 = Category.create(:parent => @category1, :name => "Non Fiction")
  end
  
  test "should have a category" do
    assert @category1
  end
  
  test "a child cat should know it's parent" do
    assert_equal @category2.parent, @category1
  end
  
  test "a parent cat should know it's children" do
    assert @category1.children.include?(@category2)
  end
  
  test "top level categories should know they are a root" do
    assert @category1.root?, "The first category should be a root node"
  end
  
  test "should know it's depth" do
    assert_equal 0, @category1.depth
    assert_equal 1, @category2.depth
    
    @category3 = Category.create(:parent => @category2, :name => "Crime")
    assert_equal 2, @category3.depth
  end
  
  test "should not allow too many generations" do
    @category3 = Category.create(:parent => @category2, :name => "Crime")
    @category4 = Category.create(:parent => @category3, :name => "Punishment")
    @category5 = Category.new(:parent => @category4, :name => "Death")
    
    assert !@category5.valid?
  end
  
  test "should have a list of the parent-less 'root' categories" do
    assert_not_nil Category.roots
  end
  
  test "should not allow duplicate names (at the same 'level')" do
    category = Category.new(:name => "Books")
    assert !category.valid?
    
    category.parent = @category1
    assert_valid category
  end
  
  test "a category with 0 for a parent_id is still a root" do
    category = Category.create(:parent_id => 0, :name => "Zero parent")
    assert Category.roots.include?(category)
    assert Category.roots.include?(@category1)
  end
end
