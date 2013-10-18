module Burning_Glass
  class Publication
    attr_accessor :type, :title, :role, :publication_date, :journal_or_serial_name, :volume, :issue, :page_number, :abstract, :copyright_date, :copyright_text, :edition, :isbn, :publisher_name, :publisher_location, :event_name, :conference_date, :conference_location, :comments, :number_of_pages

    def self.parse(publications)
      return Array.new if publications.nil?
      result = publications.css('publications').collect do |item|
        c = Publication.new
        c.title = item.text
        c
      end
      result
    end
  
  end
end
