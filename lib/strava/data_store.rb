module Strava

  class DataStore
    def initialize
      @store = {
        athletes: [],
        follows: [],
        blocks: [],
        requests: []
      }
    end

    def athletes
      @store[:athletes]
    end

    def follows
      @store[:follows]
    end

    def blocks
      @store[:blocks]
    end

    def requests
      @store[:requests]
    end

    def add_athlete(athlete)
      athletes << athlete
    end

    def add_follow(follower, followed)
      follows << { follower: follower, followed: followed } unless previously_blocked?(followed, follower)
    end

    def remove_follow(blocker, blocked)
      follows.delete_if { |e| e[:follower] == blocked && e[:followed] == blocker }
    end

    def add_block(blocker, blocked)
      blocks << { blocker: blocker, blocked: blocked }
      remove_follow(blocker, blocked)
    end

    def previously_blocked?(blocker, blocked)
      blocks.any? { |e| e[:blocker] == blocker && e[:blocked] == blocked }
    end

    def add_request(requester, requested)
      requests << { requester: requester, requested: requested }
    end

    def approve_request(approver, approved)
      add_follow(approved, approver)
      remove_request(approver, approved)
    end

    def deny_request(denier, denied)
      remove_request(denier, denied)
    end

    def remove_request(remover, removed)
      requests.delete_if { |e| e[:requester] == removed && e[:requested] == remover }
    end
  end
end
