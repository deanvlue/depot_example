class StoreController < ApplicationController
  def index
    @products=Product.order(:title) 
    @products = Product.order(:title)
  end
end
