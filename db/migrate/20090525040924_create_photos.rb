class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :content_type
      t.binary :data, :limit => 1.megabyte
    end
  end

  def self.down
    drop_table :photos
  end
end
