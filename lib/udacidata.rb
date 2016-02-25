require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	# Your code goes here!
  def self.create(attributes=nil)
    item = self.new attributes
    CSV.open(self.data_path, "a+") do |csv|
     	csv << [item.id, attributes[:brand], item, attributes[:price]]
    end
    item
  end

  def self.all
  	all = []
  	CSV.foreach(self.data_path) do |row|
  		all << row[2] unless row == ["id", "brand", "product", "price"]
  	end
  	all
  end

  def self.data_path
  	File.dirname(__FILE__) + "/../data/data.csv"
  end
end
