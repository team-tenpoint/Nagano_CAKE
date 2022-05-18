class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション設定 注文、アドレス、カート(内の商品)

  # has_many :orders, dependent: :destroy

  # has_many :address, dependent: :destroy

  # has_many :cart_items, dependent: :destroy

end
