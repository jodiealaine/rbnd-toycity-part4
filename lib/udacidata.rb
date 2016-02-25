require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	# Your code goes here!
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
  	num == 1 ? @@all.first : @@all.take(num)
  end

  def self.last
  	@@all.last
  end

  def self.data_path
  	File.dirname(__FILE__) + "/../data/data.csv"
  end
end
