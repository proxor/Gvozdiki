class CreateOrderItems < ActiveRecord::Migration
  def self.up
#    create_table :order_items do |t|
#      t.integer :product_id
#      t.integer :order_id
#      t.decimal :quantity, :precision => 8, :scale => 2
#    end
#    
#    remove_column :order, :cart_items
  end

  def self.down
#    drop_table :order_items
#    add_column :order, :cart_items, :text
  end
end
