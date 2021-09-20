class InShoppingCartsController < ApplicationController

    def create
        in_shopping_cart = InShoppingCart.new(product_id: params[:product_id], shopping_cart: @shopping_cart)

        if in_shopping_cart.save
            redirect_to "/carrito", notice: 'Guardamos el producto en tu carrito de compras'
        else
            redirect_to products_path(id:params[:product_id]), notice: 'No se pudo agregar el producto al carrito, intentalo de nuevo'
        end
    end

    def destroy
        
    end
    
    
end
