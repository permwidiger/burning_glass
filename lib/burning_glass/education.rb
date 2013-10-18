module Burning_Glass
  class Education
    attr_accessor :school_name, :city, :state, :country, :degree_name, :degree_type, :major, :minor, :gpa, :gpa_out_of, :start_date, :end_date, :graduated

    def self.parse(education_history)
      return Array.new if education_history.nil?
      result = education_history.css('school').collect do |item|
        e = Education.new
        e.school_name = item.css('institution').text
        e.city, e.state, e.country = item.css('address city, address state, address country').collect(&:text)      rescue nil
        e.degree_type = item.css('degree').blank? ? '' : item.css('degree').attr('level').text    rescue nil
        e.degree_name = item.css('degree').text
        e.major = item.css('major').text.blank? ? '' : item.css('major').text
        e.minor = item.css('minor').text.blank? ? '' : item.css('minor')
        e.gpa = item.css('gpa value').text.to_f rescue nil
        e.gpa_out_of = item.css('gpa max').text.to_f rescue nil

        if !item.css('daterange start').text.blank?
          e.start_date = Date.parse(item.css('daterange start').attr('iso8601'))     rescue nil
        else
          e.start_date = nil
        end
        if !item.css('daterange end').text.blank?
          e.end_date = Date.parse(item.css('daterange end').attr('iso8601'))              rescue nil
        else
          e.end_date = nil
        end
        #?
        e.graduated = item.css('completiondate').text != ""               rescue nil
        e
      end
      result
    end

    def graduated?
      !graduated.nil? && graduated
    end

  end
end