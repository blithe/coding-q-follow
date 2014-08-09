module Strava

  class DataStore
    def initialize
      @store = {
        athletes: [],
      }
    end

    def athletes
       @store[:athletes]
    end

    def add_athlete(athlete)
      @store[:athletes] << athlete
    end
  end
end
