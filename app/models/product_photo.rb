class ProductPhoto < ActiveRecord::Base
  belongs_to  :product
  belongs_to  :photo
end
