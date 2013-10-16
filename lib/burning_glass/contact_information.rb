module Burning_Glass
  class ContactInformation
    attr_accessor :first_name, :middle_name, :last_name, :aristocratic_title, :form_of_address, :generation, :qualification, :address_line_1, :address_line_2, :city, :state, :country, :postal_code, :home_phone, :mobile_phone, :email, :website

    def self.parse(contact_information)
      return nil if contact_information.nil?
      result = self.new
      result.first_name = contact_information.css('PersonName oa|GivenName').collect(&:text).join(" ")
      result.middle_name = contact_information.css('PersonName MiddleName').collect(&:text).join(" ")
      result.last_name = contact_information.css('PersonName FamilyName').collect(&:text).join(" ")
      #?
      result.aristocratic_title = contact_information.css('PersonName Affix[type=aristocraticTitle]').collect(&:text).join(" ")
      result.form_of_address = contact_information.css('PersonName Affix[type=formOfAddress]').collect(&:text).join(" ")
      result.generation = contact_information.css('PersonName Affix[type=generation]').collect(&:text).join(" ")
      result.qualification = contact_information.css('PersonName Affix[type=qualification]').collect(&:text).join(" ")

      address = contact_information.css('Communication Address oa|AddressLine').collect(&:text)
      result.address_line_1 = address[0] if address.length > 0
      result.address_line_2 = address[1] if address.length > 1
      result.city = contact_information.css('Communication Address oa|CityName').text rescue nil
      result.state = contact_information.css('Communication Address oa|CountrySubDivisionCode').text rescue nil
      result.postal_code = contact_information.css('Communication Address oa|PostalCode').text rescue nil
      result.country = contact_information.css('Communication Address CountryCode').text rescue nil

      result.home_phone = contact_information.css('Communication oa|DialNumber').first.text rescue nil
      #?
      result.mobile_phone = contact_information.css('Communication oa|DialNumber').first.text rescue nil

      result.website = contact_information.css('Communication oa:URI').first.text rescue nil
      #?
      result.email = contact_information.css('Communication oa:URI').first.text rescue nil

      result
    end
  end
end
