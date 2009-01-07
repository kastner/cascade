class ArticlesController < ApplicationController
  def new
    @categories = Category.roots
  end
end
