module Burning_Glass
  class Achievement
    attr_accessor :description

    def self.parse(achievements)
      return Array.new if achievements.nil?
      result = achievements.css('honors').collect do |item|
        c = Achievement.new
        c.description = item.text
        c
      end
      result
    end

  end
end