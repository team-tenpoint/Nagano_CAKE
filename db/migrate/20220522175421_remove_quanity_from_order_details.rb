class RemoveQuanityFromOrderDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :quanity, :string
  end
end
