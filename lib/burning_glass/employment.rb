module Burning_Glass
  class Employment
    attr_accessor :employer, :division, :city, :state, :country, :title, :description, :start_date, :end_date, :current_employer

    def self.parse(employment_history)
      return Array.new if employment_history.nil?
      result = employment_history.css('job').collect do |item|
        e = Employment.new
        e.employer = item.css('employer').text
        e.division = item.css('department').text
        e.division = nil if e.employer == e.division
        item.css('address').collect do |addy|
          e.city = addy.css('city').text
          e.state = addy.css('state').text
          e.country = addy.css('country').text
        end
        e.title = item.css('title').text
        e.description = item.css('description').text
        e.start_date = Date.parse(item.css('daterange start').text) rescue nil
        e.current_employer = item['DateText'] == "true"
        e.end_date = e.current_employer ? nil : (Date.parse(item.css('daterange end').text) rescue nil)
        e
      end
      result
    end

    def current_employer?
      !current_employer.nil? && current_employer
    end

  end
end

