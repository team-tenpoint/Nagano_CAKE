class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items

  with_options presence: true do
    validates :name
    validates :opinion
    validates :image
    validates :price_without_tax
    validates :genre_id
  end
end
