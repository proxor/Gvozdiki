class StoreController < ApplicationController
                                            
  protect_from_forgery :except => :product_card
  

  def index
    @categories_groups = categories_groups
  end

  def category
    begin
      @category = Category.find(params[:id])
      @categories_groups = categories_groups

    rescue ActiveRecord::RecordNotFound
      
      flash[:notice] = "И откуда вы взяли такой код категории?"
      redirect_to :acton => :index
    end
  end
  
  def product
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "И откуда вы взяли такой код товара?"
      redirect_to :acton => :index
    end
  end
  
  def price_table
    # If category is opened, we must close it.
    if session[:opened_categories] && session[:opened_categories].index(params[:category])
      logger.info("Previously asked category #{params[:category]}.")
      session[:opened_categories].delete(params[:category])
      render :text => "";
    else
      logger.info("Not ever asked category #{params[:category]}.")
      session[:opened_categories] ||= Array.new
      session[:opened_categories] << params[:category]
      
      render :partial => 'price_table', 
      :locals => {
        :category => params[:category], 
        :order => params[:order]}
    end
    
    
  end

  def view_cart
    @cart = find_cart
    if @cart.items.count == 0
      flash[:notice] = 'Ваша корзина пока пуста. Положите туда товар из каталога, кликнув нужную позицию.'
      redirect_to :action => :index
    end
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Попытка добавить в корзину несуществующий товар c id #{params[:id]}.")
      flash[:notice] = "Товар с таким id отсутсвует в базе."
      redirect_to :action => :index
    else
      @cart = find_cart
      @cart.add_product(product)
      flash[:notice] = "Товар добавлен."
    end
    redirect_to :action => :view_cart
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Корзина очищена. Наполните ее товарами из каталога."
    redirect_to :action => :index
  end

  def change_quantity
    product = params[:product]
    quantity = params[:quantity]
    
    @cart = find_cart
    @cart.change_quantity(product,quantity);
    
    cart
  end
  
  def cart
    logger.info "Requesting the cart"
    @cart = find_cart
    render :partial => 'cart'
  end
  
  def product_card
    @product = Product.find(params[:id])
    
    if session[:user_id] 
      render :partial => 'product_card_edit'
    else
      render :partial => 'product_card'
    end
    
  end
  
private
  def find_cart
   session[:cart] ||= Cart.new
  end
  
  def categories_groups
    groups = []
    Category.find(:all, :group => "[group]").each do |g|
      groups << Category.find(:all, :conditions => ["[group] = #{g.group}"])
    end
    groups
  end
  
  def authorize
  end
  
end
