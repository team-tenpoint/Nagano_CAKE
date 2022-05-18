class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total_price = @order_details.sum{|order_detail|order_detail.price_including_tax * order_detail.quanity}
  end

  def update
    @order = Order.find(params[:id])
		if @order.update(order_params)
		   redirect_to admin_order_path(@order)
		else
		   render show
		end
  end

  private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
