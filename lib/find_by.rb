class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
        new_finder_method = %{
          def self.find_by_#{attribute}(item)	
          	@@all.each {|product| return product if product.#{attribute} == item}	
          end
    	}
		self.class_eval new_finder_method
    end
  end
end
