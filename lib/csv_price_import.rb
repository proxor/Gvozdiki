# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'csv'

module CsvPriceImport
    # Importing price from CSV maden by price.xls from Palitra-Trade
    def self.import_price(source, category)
     
      # Check file exists
      if !File.exist?(source) 
        Exception.new("Отсутсвует файл-источник: #{source}.")
      end

      # Reading line-by-line
      # Fields: *,1,code,title,article,price
      count = 0
      CSV.open(source, 'r', col_sep = ?;) do |row|
        # Check if the row is not a product info row
        if row[0] != "*"
          next
        end
        
        # Code of the product is a unique value.
        # If product with the code exists, all data should be updated.
        
        # Looking for product with the same code
        price_items = Product.find(:all, :conditions => ["code = #{row[2]}"])
        if price_items.count > 0
          price_item = price_items[0]
          price_item.title = row[3]
          price_item.article = row[4]
          #price_item.categories << Category.find(category["id"])

          price_item.price = row[5]
        
          price_item.save
        else
          price_item = Product.new
          price_item.code = row[2]
          price_item.title = row[3]
          price_item.article = row[4]
          price_item.categories << Category.find(category["id"])

          price_item.price = row[5]
          
          price_item.save
          
          count += 1
        end
      end
      
      return count
    end
end
