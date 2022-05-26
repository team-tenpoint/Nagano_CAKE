class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find_by(id: @order_detail.order_id)
    @order_details = @order.order_details

    @order_detail.update(order_detail_params)
    count = 0
    @order_details.each do |order_detail|
      if order_detail.make_status == "production_completed"
        count += 1
      end
    end
    if params[:order_detail][:make_status] == "production"
      @order.update_attribute(:order_status, 2)
    end
    if @order_details.count == count
      @order.update_attribute(:order_status, 3)
    end
    redirect_to admin_order_path(@order_detail.order_id)
    flash[:notice] = "制作ステータスを更新しました。"
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end
end