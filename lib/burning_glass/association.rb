module Burning_Glass
  class Association
    attr_accessor :name, :role

    def self.parse(associations)
      return Array.new if associations.nil?
      result = associations.css('affiliations').collect do |item|
        c = Association.new
        c.name = item.text
        #c.role = item.css('Role Name').text
        c
      end
      result
    end
  
  end
end