class Public::OrdersController < ApplicationController


   def new
    @order = Order.new
   end

  def create
    # @order_new = Order.new
    # @order = current_customer
    @cart_items = current_customer.cart_items.all
     @order = current_customer.order.new(order_params)
   
    @order_new.save

      @cart_items.each do |cart_item|       # カートのデータも併せて保存できるようにする
      @cart_item = CartItem.new
      @cart_item.item_id = CartItem.ids
      @cart_item.customer_id = current_customer.id
      @cart_item.delivery_address = CartItem.delivery_address
      @cart_item.postal_code = CartItem.postal_code
      @cart_item.postage = CartItem.postage
      @cart_item.payment_method = CartItem.payment_method
      @cart_item.save
     end
      current_customer.cart_items.destroy_all        # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      redirect_to confirm_path
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
   @order = current_customer.orders.find(params[:id])
   @cart_items = current_customer.cart_items
   @order_postage = 800
  end


  private

  def order_params
    params.require(:order).permit(:delivery_address, :postal_code, :delivery_name, :postage, :total_price, :payment_method, :order_status, :cart_image, :cart_item)
  end

end
