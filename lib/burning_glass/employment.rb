module Burning_Glass
  class Employment
    attr_accessor :employer, :division, :city, :state, :country, :title, :description, :start_date, :end_date, :current_employer

    def self.parse(employment_history)
      return Array.new if employment_history.nil?
      result = employment_history.css('EmployerHistory').collect do |item|
        position = item.css('PositionHistory').first
        e = Employment.new
        e.employer = item.css('OrganizationUnitName').text
        e.division = position.css('OrganizationName').text
        e.division = nil if e.employer == e.division
        item.css('OrganizationContact Communication Address').collect do |addy|
          e.city = addy.css('oa|CityName').text
          e.state = addy.css('oa|CountrySubDivisionCode').text
          e.country = addy.css('CountryCode').text
        end
        e.title = position.css('PositionTitle').text
        e.description = position.css('oa|Description').text
        e.start_date = Date.parse(position.css('StartDate').text) rescue nil
        e.current_employer = position['DateText'] == "true"
        e.end_date = e.current_employer ? nil : (Date.parse(position.css('EndDate').text) rescue nil)
        e
      end
      result
    end

    def current_employer?
      !current_employer.nil? && current_employer
    end

  end
end

