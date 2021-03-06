class Category < ActiveRecord::Base
  has_many :category_products#, :dependent => :nullify
  has_many :products, :through => :category_products

  validates_presence_of :title
end
