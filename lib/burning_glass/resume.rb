require 'json'

module Burning_Glass
  class Resume
    attr_accessor :executive_summary, :objective, :contact_information, :education_history, :employment_history, :certifications, :competencies, :achievements, :associations, :languages, :military_history, :patent_history, :publication_history, :references

    def self.parse(resume)
      parsed_resume = Nokogiri::XML.parse(resume)
      resume = self.new
      resume.executive_summary = parsed_resume.css('ResDoc summary summary').text
      resume.objective = parsed_resume.css('ResDoc summary objective').text
      resume.employment_history = Employment.parse(parsed_resume.css('ResDoc experience').first)
      resume.education_history = Education.parse(parsed_resume.css('ResDoc education').first)
      resume.contact_information = ContactInformation.parse(parsed_resume.css('ResDoc contact').first)
      resume.competencies = Competency.parse(parsed_resume.css('skillrollup') )
      resume.languages = Language.parse(parsed_resume.css('skills').first)
      resume.references = Reference.parse(parsed_resume)   # references are a top level node with no children, so pass in the resume and work down
      resume.certifications = Certification.parse(parsed_resume.css('skills').first)
      resume.associations = Association.parse(parsed_resume.css('professional').first)
      resume.publication_history = Publication.parse(parsed_resume.css('professional').first)

      # not sure if statements.honors is correct for achievements?
      resume.achievements = Achievement.parse(parsed_resume.css('statements').first)

      # todo
      #resume.military_history = Military.parse(parsed_resume.css('MilitaryHistory').first)
      #resume.patent_history = Patent.parse(parsed_resume.css('PatentHistory').first)

      # todo testing - check language return, see if the languages.language node ever returns, if so, we wont get those


      resume
    end

    def self.get_year_from_bg_days(bg_days)
      # bg_days comes in as a string where the int version / 365 = the origin year
      # ex. '731704' = 731704 / 365 =  2008
       (Integer(bg_days) / 365).floor
    end


  end
end