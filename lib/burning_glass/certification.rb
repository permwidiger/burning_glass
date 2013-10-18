module Burning_Glass
  class Certification
    attr_accessor :name, :description, :effective_date

    def self.parse(certifications)
      return Array.new if certifications.nil?
      result = certifications.css('courses').collect do |item|
        c = Certification.new
        c.name = item.text
        c.description = item.css('skill').text

        c
      end
      result
    end
  
  end
end