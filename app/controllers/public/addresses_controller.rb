class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path, notice: '配送先の新規登録がされました。'
    else
      @addresses =current_customer.addresses
      flash.now[:alert] = '空欄を埋めてください。'
      render "index"
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: '配送先情報が更新されました。'
    else
      flash.now[:alert] = '空欄を埋めてください。'
      render "edit"
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先情報が削除されました。"
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :postal_code)
  end
end
