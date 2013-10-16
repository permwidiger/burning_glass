module Burning_Glass
  class Competency
    attr_accessor :name, :months, :last_used_date

    def self.parse(competencies)
      return Array.new if competencies.nil?
      results = competencies.css('Competency').collect do |item|
        c = Competency.new
        c.name = item['name']
        c.months = item.css('CompetencyWeight StringValue').text rescue nil
        c.last_used_date = item.css('CompetencyWeight SupportingInformation').first.text rescue nil
        c
      end
      results
    end

  end
end