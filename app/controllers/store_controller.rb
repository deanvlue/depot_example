class StoreController < ApplicationController
  def index
<<<<<<< HEAD
    @products=Product.order(:title) 
=======
    @products = Product.order(:title)
>>>>>>> 708923a163fa30507ffab6218f8c6b284f19b137
  end
end
