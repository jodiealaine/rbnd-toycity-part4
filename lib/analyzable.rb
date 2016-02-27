module Analyzable
  def average_price products
  	(products.map{|product| product.price}.reduce(:+) / products.count).round(2)
  end
  def print_report products	
    brand_totals = calculate_brand_totals(brands_list(products))
  	name_totals = calculate_name_totals(names_list(products))
  	generate_report(brand_totals, name_totals, brand_totals, name_totals)
  end

  def count_by_brand products
 		calculate_brand_totals(brands_list(products))
  end

  def count_by_name products
 		calculate_name_totals(names_list(products))
  end

  def brands_list products
  	products.map {|product| product.brand}
  end

  def names_list products
  	products.map {|product| product.name}
  end

  def calculate_brand_totals brands
  	brand_totals = Hash.new 0
  	brands.each do |brand|
  	brand_totals[brand] += 1
		end
		brand_totals
  end

  def calculate_name_totals names 
  	name_totals = Hash.new 0
		names.each do |name|
			name_totals[name] +=1
		end
		name_totals
  end

  def generate_report brands, names, brand_totals, name_totals
  	"Inventory by Brand:\n" +
  	"#{brand_totals.map {|brand, total| "– #{brand}: #{total}\n"}.join}" +
  	 "Inventory by Name:\n" +
  	"#{name_totals.map {|name, total| "– #{name}: #{total}\n"}.join}"
  end
end
 

