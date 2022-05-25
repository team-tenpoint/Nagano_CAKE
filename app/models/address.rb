class Address < ApplicationRecord
  belongs_to :customer

  validates :name,presence:true
  validates :post_number,presence:true
  validates :address,presence:true
  
  def address_display
    "〒"+postal_code+""+address+""+name
  end
  
  

end
