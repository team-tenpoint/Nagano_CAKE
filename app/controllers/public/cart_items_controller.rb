class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: @cart_item.item_id).present?
      @current_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
      @current_cart_item.quantity += @cart_item.quantity
      if @current_cart_item.save
        redirect_to cart_items_path
      else
        @item = Item.find(params[:id])
        render "public/items/show"
      end
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
        @item = Item.find(params[:id])
        render "public/items/show"
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

end
