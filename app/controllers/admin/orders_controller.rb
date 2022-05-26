class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total_price = @order_details.sum{|order_detail|order_detail.price_including_tax * order_detail.quantity}
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if @order.order_status == "payment_confirmation"
      @order_details.update_all("make_status = 1")
    end
    flash[:notice] = "注文ステータスを更新しました。"
    redirect_to request.referer
  end

  private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
