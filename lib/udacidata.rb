require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@num = 0
  # Your code goes here!
  def self.create(attributes=nil)
    item = self.new attributes
    CSV.open(self.data_path, "a") do |csv|
     	csv << [item.id, attributes[:brand], attributes[:name], attributes[:price]]
    end
    item
  end

  def self.all
  	CSV.read self.data_path
  end

  def self.data_path
  	File.dirname(__FILE__) + "/../data/data.csv"
  end
end
