class CombineItemsInCart < ActiveRecord::Migration
  def up
    #Replace multiple items for a single product in a cart in a single line
    Cart.all.each do |cart|
      # cuenta el numero de productos en cada carrito
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do | product_id, quantity |
        if quantity > 1
          # Remover items individuales para poder agruparlos en la siguiente orden
          cart.line_items.where(product_id: product_id).delete_all

          # Reemplaza con un solo item y la cantidad sumarizada
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    # separa los items que tienen mas de una cantidad
    LineItem.where("quantity>1").each do | line_item |
      # agregar items individuales
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end
      #remueve el item original
      line_item.destroy
    end
  end
end
