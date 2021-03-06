module Burning_Glass
  class ContactInformation
    attr_accessor :first_name, :middle_name, :last_name, :aristocratic_title, :form_of_address, :generation, :qualification, :address_line_1, :address_line_2, :city, :state, :country, :postal_code, :home_phone, :mobile_phone, :email, :website

    def self.parse(contact_information)
      return nil if contact_information.nil?
      result = self.new
      result.first_name = contact_information.css('name givenname').collect(&:text).join(" ")
      result.last_name = contact_information.css('name surname').collect(&:text).join(" ")
      result.aristocratic_title = contact_information.css('name honorific').collect(&:text).join(" ")
      result.qualification = contact_information.css('name namesuffix').collect(&:text).join(" ")

      address = contact_information.css('address street').collect(&:text)
      result.address_line_1 = address[0] if address.length > 0
      result.address_line_2 = address[1] if address.length > 1
      result.city = contact_information.css('address city').text rescue nil
      result.state = contact_information.css('address state').text rescue nil
      result.postal_code = contact_information.css('address postalcode').text rescue nil
      result.country = contact_information.css('address country').text rescue nil

      if !contact_information.css('phone').first.blank?
        result.home_phone = contact_information.css('phone').first.text rescue nil
      else
        result.home_phone = contact_information.css('phone home').first rescue nil
        end

      result.mobile_phone = contact_information.css('phone cell').first rescue nil

      result.website = contact_information.css('website').first rescue nil

      result.email = contact_information.css('email').first rescue nil

      result
    end
  end
end
