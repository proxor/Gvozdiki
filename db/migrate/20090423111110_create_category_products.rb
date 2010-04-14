class CreateCategoryProducts < ActiveRecord::Migration
  def self.up
    create_table :category_products do |t|
      t.column :product_id, :integer, :null => false
      t.column :category_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :category_products
  end
end
