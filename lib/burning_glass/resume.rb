require 'json'

module Burning_Glass
  class Resume
    attr_accessor :executive_summary, :objective, :contact_information, :education_history, :employment_history, :certifications, :competencies, :achievements, :associations, :languages, :military_history, :patent_history, :publication_history, :references

    def self.parse(resume)
      parsed_resume = Nokogiri::XML.parse(resume)
      resume = self.new
      resume.executive_summary = parsed_resume.css('ExperienceSummary').text
      resume.objective = parsed_resume.css('CandidateObjective').text
      resume.employment_history = Employment.parse(parsed_resume.css('EmploymentHistory').first)
      resume.education_history = Education.parse(parsed_resume.css('EducationHistory').first)
      resume.contact_information = ContactInformation.parse(parsed_resume.css('CandidatePerson').first)
      resume.certifications = Certification.parse(parsed_resume.css('Licenses').first)
      resume.competencies = Competency.parse(parsed_resume.css('UserArea Competency') )
      resume.patent_history = Patent.parse(parsed_resume.css('PatentHistory').first)

      # borked?    - have yet to see these node returned
      resume.achievements = Achievement.parse(parsed_resume.css('Achievements').first)
      resume.associations = Association.parse(parsed_resume.css('OrganizationAffiliation').first)
      resume.languages = Language.parse(parsed_resume.css('Languages').first)
      resume.military_history = Military.parse(parsed_resume.css('MilitaryHistory').first)
      resume.references = Reference.parse(parsed_resume.css('EmploymentReferences').first)

      # needs model work, significant result differences
      resume.publication_history = Publication.parse(parsed_resume.css('PublicationHistory').first)


      resume
    end

  end
end