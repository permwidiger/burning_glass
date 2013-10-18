module Burning_Glass
  class Competency
    attr_accessor :name, :months, :last_used_date

    def self.parse(competencies)
      return Array.new if competencies.nil?
      results = competencies.css('canonskill').collect do |item|
        c = Competency.new
        c.name = item['name']
        bg_days = item['start']
        c.last_used_date = item['lastused']
        c.months =  bg_days.nil? || c.last_used_date.nil? ? 0 :  determine_use_length(bg_days, c.last_used_date)
        c
      end
      results
    end

    def self.determine_use_length(start, last_used)
      # start comes in as a string where the int version / 365 = the origin year
      # ex. '731704' = 731704 / 365 =  2008
      orig_year = Resume.get_year_from_bg_days(start)
      (Integer(last_used)- orig_year) * 12
    end



  end
end