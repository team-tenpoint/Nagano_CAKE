class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  with_options presence: true do
    validates :name ,uniqueness: true
    validates :opinion ,uniqueness: true
    validates :image
    validates :price_without_tax ,numericality: true
    validates :genre_id
  end
end
