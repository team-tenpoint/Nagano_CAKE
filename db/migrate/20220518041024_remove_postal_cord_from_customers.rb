class RemovePostalCordFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :postal_cord, :string
  end
end
