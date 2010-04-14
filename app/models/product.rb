class Product < ActiveRecord::Base
  has_many :category_products#, :dependent => :nullify
  has_many :categories, :through => :category_products
  
  has_many :product_photos#, :dependent => :nullify
  has_many :photos, :through => :product_photos
  belongs_to :item_type

  def category_ids
    categories.map(&:id)
  end
  
  def self.search_by_request(request)
    request.gsub!(' ', '%')
    Product.find(:all, :conditions => ["title like ?","%#{request}%"])
  end
  
  validates_presence_of :code, :title
  validates_numericality_of :code, :only_integer => true
  validates_numericality_of :price
end
