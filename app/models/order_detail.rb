class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum make_status:{ not_startable:0, waiting_for_production:1, production:2, production_completed:3}
  
  with_options presence: true do
    validates :make_status
    validates :price_including_tax ,numericality: true
    validates :quantity ,numericality: true
  end
end

