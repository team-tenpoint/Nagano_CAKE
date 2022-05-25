class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total_price = @order_details.sum{|order_detail|order_detail.price_including_tax * order_detail.quantity}
  end

  def update
    @order = Order.find(params[:id])
		if @order.update(order_params)
		   flash[:notice] = "注文ステータスを更新しました。"
		   redirect_to admin_order_path(@order)
		else
		   render "show"
		end
  end

  private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
