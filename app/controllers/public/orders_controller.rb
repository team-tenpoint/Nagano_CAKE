class Public::OrdersController < ApplicationController


  def new
    @order = Order.new

  end

  def confirm
    @order = Order.new
    @order_customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order_postage = 800
    @total = 0
  end

  def create
    @order = Order.new(order_params)

  end

  def complete
  end


  # order_ditail用
  def index
   @orders = Orders.all
  end

  def show
   @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:delivery_address, :postal_code, :delivery_name, :postage, :total_price, :payment_method, :order_status, :cart_image, :cart_item)
  end

end
