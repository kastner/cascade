class ArticlesController < ApplicationController
  def new
    @categories = Category.roots
  end
  
  def create
    @categories = Category.roots
    @category_ancestory = params[:categories]
    render :action => "new"
  end
end
