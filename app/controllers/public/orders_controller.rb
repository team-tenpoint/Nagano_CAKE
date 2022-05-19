class Public::OrdersController < ApplicationController


  def new
    @order = Order.new
    # @address = Address.new
  end

  def confirm
    @order = Order.new

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
