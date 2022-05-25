class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to customer_path, notice: "会員情報が更新されました。"
    else
      flash.now[:alert] = '空欄を埋めてください。'
      render "edit"
    end
  end

  def quit
  end

  def out
    # @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    current_customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会手続きが完了しました。またのご利用をお待ちしています。"
    redirect_to root_path
  end



  private

   def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :password, :is_deleted)
   end



end
