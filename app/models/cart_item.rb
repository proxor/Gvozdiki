class CartItem
  attr_reader :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end

  def change_quantity(q)
    @quantity = q.to_d
  end
  
  def title 
    @product.title
  end

  def price 
    @product.price * @quantity
  end
end
