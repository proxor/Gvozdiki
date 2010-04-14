class CreateCatProdJoinTable < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id => false do |t|
      t.integer :product_id
      t.integer :category_id
    end

    add_index :categories_products, [:product_id, :category_id], :unique => true
    add_index :categories_products, :category_id, :unique => false
  end

  def self.down
    drop_table :categories_products
  end
end
