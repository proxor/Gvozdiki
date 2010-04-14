class AddGroupAndOrderColumns < ActiveRecord::Migration
  def self.up
    add_column :categories, :group, :integer, :default => -1
    add_column :categories, :group_order, :integer, :default => -1 
  end

  def self.down
    remove_column :categories, :group
    remove_column :categories, :group_order
  end
end
