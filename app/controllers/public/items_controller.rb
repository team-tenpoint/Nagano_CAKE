class Public::ItemsController < ApplicationController


  def about

  end

  def top
    @items = Item.where(is_active: true)
  end

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


end
