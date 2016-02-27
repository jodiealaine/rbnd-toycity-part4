require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata  
	create_finder_methods :brand, :name
  def self.create(attributes=nil)
    item = self.new attributes
    unless self.item_exists? item
			CSV.open(self.data_path, "a+") do |csv|
     		csv << [item.id, item.brand, item.name, item.price]  
    	end
    end
   	item
  end

  def self.all
  	product_instances = []
  	all = CSV.table(self.data_path, write_headers: true)
  	all.each do|row|
  	  product_instances << self.create(id: row[:id], brand: row[:brand], name: row[:product], price: row[:price])
  	end
  	product_instances
  end

  def self.first num=1
  	return self.all.first if num == 1 
		self.all.first(num)
  end

  def self.last num=1
  	num == 1 ? self.all.last : self.all.last(num)
  end

  def self.find id
  	self.all.each {|product| return product if product.id == id }
  	raise ProductNotFoundError, "Product id:#{id} not found"
  end

  def self.destroy id
  	
    deleted_product = self.find id
  	raise ProductNotFoundError, "Product id:#{id} not found" if self.find(id) == false 
  	
  	data_table = CSV.table(self.data_path, write_headers: true)
		
		updated_data_table = data_table.delete_if {|row| row[:id] == id}

		File.open(self.data_path, "w") do |f|
 			f.write(updated_data_table.to_csv)
  	end

  	deleted_product
  end
  
  def self.where options={}
		products = []
  	self.all.each do |product|
  	  products << product if (product.brand == options[:brand] || product.name == options[:name])
  	end
  	products
  end

  def update options={}
  	@brand = options[:brand] if options[:brand]
  	@price = options[:price] if options[:price]
  	data_table = CSV.table(self.class.data_path, write_headers: true)
		data_table.each do |row|
  		if row[:id] == id
  			row[:brand] = options[:brand] if options[:brand]
  			row[:price] = options[:price] if options[:price]
  		end
		end

		File.open(self.class.data_path, 'w') do |f|
  		f.write(data_table.to_csv)
		end
		self
  end

  def self.item_exists? item
  	database = CSV.read(self.data_path)
    item_exists = false
    database.each {|row| item_exists = true if row[0] == item.id.to_s }
    item_exists
  end

  def self.data_path
  	File.dirname(__FILE__) + "/../data/data.csv"
  end
end
