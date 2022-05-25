class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
     @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price_including_tax = cart_item.item.price_without_tax*1.1
      @order_detail.quantity = cart_item.quantity
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      if current_customer.addresses.exists?
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.delivery_address = @address.address
        @order.delivery_name = @address.name
      else
        flash.now[:alert] = '登録済み住所がありません。'
        render "new"
      end
    elsif params[:order][:select_address] == "2"
      @address = Address.new
      @address.customer_id = current_customer.id
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:delivery_address]
      @address.name = params[:order][:delivery_name]
      if @address.save
        @order.postal_code = @address.postal_code
        @order.delivery_address = @address.address
        @order.delivery_name = @address.name
      else
        flash.now[:alert] = '住所を正しく入力してください。'
        render "new"
      end
    else
      render "new"
    end
    @cart_items = current_customer.cart_items
    @postage = 800
    @total_price = 0
  end

  def complete

  end

  def order_params
    params.require(:order).permit(:delivery_address, :postal_code, :delivery_name, :postage, :total_price, :payment_method)
  end

end
