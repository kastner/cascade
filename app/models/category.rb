class Category < ActiveRecord::Base
  validates_presence_of :name
  validate :not_nested_too_deeply
  
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"
  
  named_scope :roots, :conditions => {:parent_id => nil}
  
  def self.max_depth
    4
  end
  
  def root?
    parent_id.nil? || parent_id == 0
  end
  
  def depth
    return 0 if root?
    return 1 + parent.depth
  end

 private
  def not_nested_too_deeply
    errors.add("Nested too deeply") if depth >= Category.max_depth
  end
end
