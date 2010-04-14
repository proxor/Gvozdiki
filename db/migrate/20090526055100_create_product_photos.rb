class CreateProductPhotos < ActiveRecord::Migration
  def self.up
    create_table :product_photos do |t|
      t.column :product_id, :integer, :null => false
      t.column :photo_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :product_photos
  end
end
