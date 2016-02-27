require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata  
	create_finder_methods :brand, :name
	@@all = []
  def self.create(attributes=nil)
    item = self.new attributes
    CSV.open(self.data_path, "a+") do |csv|
     	csv << [item.id, item.brand, item.name, item.price]
    end
   	@@all << item
   	item
  end

  def self.all
  	@@all
  end

  def self.first num=1
  	return @@all.first if num == 1 
		first_num_rows = CSV.table(self.data_path, write_headers: true).first(num)
  	first_num = []
  	first_num_rows.each do |row|
  	 	first_num << self.find(row[:id])
  	end
  	first_num
  end

  def self.last num=1
  	num == 1 ? @@all.last : @@all.last(num)
  end

  def self.find id
  	@@all.each {|product| return product if product.id == id }
  	raise ProductNotFoundError, "Product id:#{id} not found"
  end

  def self.destroy id
  	raise ProductNotFoundError, "Product id:#{id} not found" if self.find(id) == false 
  	
  	data_table = CSV.table(self.data_path, write_headers: true)
		data_table.delete_if do |row|
  		row[:id] == id
		end
		
		File.open(self.data_path, 'w') do |f|
  		f.write(data_table.to_csv)
		end
		@@all.delete(self.find id)
  end
  
  def self.where options={}
		products = []
  	@@all.each do |product|
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

  def self.data_path
  	File.dirname(__FILE__) + "/../data/data.csv"
  end
end
