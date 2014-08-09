require 'active_support/all'

module Strava
  module Models
    class Athlete
      attr_accessor :id, :first_name, :last_name, :dob

      def initialize(id, first_name, last_name, dob)
        @id = id
        @first_name = first_name
        @last_name = last_name
        @dob = dob
      end

      def age(today = Date.today)
        if today.yday >= dob.yday
          today.year - dob.year
        else
          today.year - dob.year - 1
        end
      end
    end
  end
end
