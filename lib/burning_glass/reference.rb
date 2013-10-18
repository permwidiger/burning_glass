module Burning_Glass
  class Reference
    attr_accessor :name, :title, :email, :phone_number

    def self.parse(references)
      return Array.new if references.nil?
      result = references.css('references').collect do |item|
        r = Reference.new
        r.name = item.text
        r
      end
      result
    end
  end
end