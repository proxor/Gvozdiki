class Order < ActiveRecord::Base
  has_many :order_items
  #has_many :products, :through => :order_items
  
  validates_presence_of :phone
  # Телефоны можно перечислять через запятую
  #validates_format_of :phone => /^((([ ()-]?\d[ ()-]?){6,11})[ ,;]*)+$/
  #validates_format_of :e_mail => /^((\w)(\.\2))+@\1\w/
  
end
