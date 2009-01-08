class CategoriesController < ApplicationController
  def show
    category = Category.find(params[:id])
    @categories = category.children if category
    render :partial => "articles/categories.html.erb", :status => :ok
  end
  
  def create
    category = Category.new(params[:category])
    if category.save
      @categories = category.parent.nil? ? Category.roots : category.parent.children
      render :partial => "articles/categories", :status => :ok
    else
      render :text => category.errors.full_messages.join("\n"), :status => :bad_request
    end
  end
end
