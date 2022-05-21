class Public::OrdersController < ApplicationController

   def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

      @cart_items.each do |cart_item|       # カートのデータも併せて保存できるようにする
      @order_item = OrderItem.new
      @order_item.item_id = cart.item_id
      @order_item.order_id = @order.id
      @order_item.order_quantity = cart.quantity
      @order_item.order_price = cart.item.price
      @order_item.save
     end
      current_customer.cart_items.destroy_all        # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      redirect_to complete_path
   end



  def new
    @order = Order.new
  end


  def confirm
    @order = Order.new
    @order_customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order_postage = 800
  end


  def complete
  end


  # order_ditail用
  def index
   @orders = current_customer.orders.all
  end

  def show
   @order = current_customer.or.find(params[:id])
   @cart_items = current_customer.cart_items
   @order_postage = 800
  end


  private

  def order_params
    params.require(:order).permit(:delivery_address, :postal_code, :delivery_name, :postage, :total_price, :payment_method, :order_status, :cart_image, :cart_item)
  end

end
