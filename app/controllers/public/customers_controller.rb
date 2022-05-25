class Public::CustomersController < ApplicationController

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



  private

   def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :password, :is_deleted)
   end



end
