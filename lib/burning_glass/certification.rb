module Burning_Glass
  class Certification
    attr_accessor :name, :description, :effective_date

    def self.parse(certifications)
      return Array.new if certifications.nil?
      result = certifications.css('License').collect do |item|
        c = Certification.new
        c.name = item.css('LicenseName').text
        c.description = item.css('oa|Description').text
        c.effective_date = Date.parse(item.css('FirstIssuedDate').text) rescue nil
        c
      end
      result
    end
  
  end
end