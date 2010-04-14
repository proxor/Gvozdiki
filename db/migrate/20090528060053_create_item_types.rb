class CreateItemTypes < ActiveRecord::Migration
  def self.up
    create_table :item_types do |t|
      t.string :name
    end
    
    add_column :products, :item_type_id, :indeger
  end

  def self.down
    drop_table :item_types
    remove_column :products, :item_type_id
  end
end
