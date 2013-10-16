module Burning_Glass
  class Education
    attr_accessor :school_name, :city, :state, :country, :degree_name, :degree_type, :major, :minor, :gpa, :gpa_out_of, :start_date, :end_date, :graduated
    
    def self.parse(education_history)
      return Array.new if education_history.nil?
      result = education_history.css('EducationOrganizationAttendance').collect do |item|
        e = Education.new
        e.school_name = item.css('OrganizationName').text
        #?
        e.city, e.state, e.country = item.css('PostalAddress Municipality, PostalAddress Region, PostalAddress CountryCode').collect(&:text)
        e.degree_type = item.css('ProgramName').text
        e.degree_name = item.css('EducationDegree DegreeName').text
        e.major = item.css('EducationDegree DegreeMajor ProgramName').text
        e.minor = item.css('EducationDegree DegreeMinor ProgramName').text
        e.gpa = item.css('EducationScore').text.to_f rescue nil
        e.gpa_out_of = item.css('EducationScore').text.to_f rescue nil
        #?
        e.start_date = Date.parse(item.css('DatesOfAttendance StartDate AnyDate').text) rescue nil
        #?
        e.end_date = Date.parse(item.css('DatesOfAttendance EndDate AnyDate').text) rescue nil
        #?
        e.graduated = item.css('Degree DegreeDate AnyDate').text != ""
        e
      end
      result
    end
  
    def graduated?
      !graduated.nil? && graduated
    end  

  end
end