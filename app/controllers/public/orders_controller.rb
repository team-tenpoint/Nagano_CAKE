class Public::OrdersController < ApplicationController


   def new
    @order = Order.new
   end

  def create
   @order = Order.new(order_params)
   @order.customer_id = current_customer.id
   @order.postage = 800
   @order.total_price = current_customer.cart_items
   @cart_items = current_customer.cart_items
   @total_price = 0
   @cart_items.each do |cart_item|
    @total_price += (cart_item.item.price_without_tax * 1.1).floor * (cart_item.quantity)
   end
   @order.total_price = @total_price

   @order.save
   redirect_to confirm_path
  end



   def confirm
    @order = Order.new
    @order_customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order_postage = 800
    redirect_to 
   end




  def complete
  end


  # order_ditail用
  def index
   @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders
   # @cart_items = current_customer.cart_items
   @order_postage = 800
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :delivery_address, :postal_code, :delivery_name, :total_price, :payment_method, :cart_image, :cart_item)
  end

end
