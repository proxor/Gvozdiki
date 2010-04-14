class SearchController < ApplicationController
  layout 'store'

  def index
  end
  
  def go
    @request = params[:request]
    if !@request || @request.length == 0
      flash[:notice] = "Кто ничего не ищет &#151; тот ничего не находит.";
      redirect_to :action => :index;
    end
    
    @match_products = Product.search_by_request(params[:request])
    @order = 'title'
  end

end
