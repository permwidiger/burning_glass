require 'burning_glass/version'
require 'bundler/setup'
require 'savon'
require 'httpclient'
require 'nokogiri'

module Burning_Glass
  class << self
    FIELDS = [:endpoint, :instanceCode ]
    attr_accessor(*FIELDS)

    def configure
      yield self
      true
    end
  end

  require_relative 'burning_glass/achievement'
  require_relative 'burning_glass/association'
  require_relative 'burning_glass/certification'
  require_relative 'burning_glass/client'
  require_relative 'burning_glass/competency'
  require_relative 'burning_glass/contact_information'
  require_relative 'burning_glass/education'
  require_relative 'burning_glass/employment'
  require_relative 'burning_glass/resume'
  require_relative 'burning_glass/language'
  require_relative 'burning_glass/military'
  require_relative 'burning_glass/patent'
  require_relative 'burning_glass/publication'
  require_relative 'burning_glass/reference'
  
  
end

