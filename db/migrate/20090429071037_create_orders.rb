class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :e_mail
      t.text   :cart_items
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
