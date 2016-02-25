require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
	@@num = 0
  # Your code goes here!
  def self.create(attributes=nil)
    item = self.new attributes
    data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(data_path, "a") do |csv|
     	csv << [item.id, attributes[:brand], attributes[:name], attributes[:price]]
    end
    item
  end
end
