class ImportController < ApplicationController
  before_filter :authorize
  
  layout 'store'
  
  def index
    
  end
  
  def import_csv
    #PriceFile.save(params[:source])
    # CSV data source (filename)
    source = params[:source]

    name = source['pricefile'].original_filename
    directory = "public/data/prices"
    path = File.join(directory, name)
    
    File.open(path, "wb") {|f| f.write(source['pricefile'].read) }
    
    count = CsvPriceImport::import_price(path, params[:category])
    
    
    flash[:notice] = "#{count} позиций из CSV-файла импортировано в базу."
    
    redirect_to :controller => "store", :action => "index"
  end 
end
