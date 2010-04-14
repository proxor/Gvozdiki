class ChangeCodeType < ActiveRecord::Migration
  def self.up
    change_column :products, :code, :decimal, :default => 0, :precision => 6, :scale => 0
  end

  def self.down
    change_column :products, :code, :decimal
  end
end
