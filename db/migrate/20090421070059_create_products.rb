class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.decimal :code
      t.string :article
      t.string :title
      t.string :img_url
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
