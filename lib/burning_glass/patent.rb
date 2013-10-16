module Burning_Glass
  class Patent
    attr_accessor :title, :description, :inventor_name, :patent_id

    def self.parse(patents)
      return Array.new if patents.nil?
      result = patents.css('Patent').collect do |item|
        c = Patent.new
        c.title = item.css('PatentTitle').text
        c.description = item.css('oa|Description').text
        c.inventor_name = item.css('InventorName').first.text rescue nil
        c.patent_id = item.css('PatentID').text
        c
      end
      result
    end
  
  end
end
