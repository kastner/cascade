class CategoriesController < ApplicationController
  def show
    category = Category.find(params[:id])
    @children = category.children if category
  end
end
