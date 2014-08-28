module Strava
  module Services
    class FollowService
      def initialize(data_store)
        @data_store = data_store
      end

      def people_followed_by(athlete)
        @data_store.follows.collect { |e| e[:followed] if e[:follower] == athlete }.compact
      end

      def people_following(athlete)
        @data_store.follows.collect { |e| e[:follower] if e[:followed] == athlete }.compact
      end

      def people_blocked_by(athlete)
        @data_store.blocks.collect { |e| e[:blocked] if e[:blocker] == athlete }.compact
      end

      def people_blocking(athlete)
        @data_store.blocks.collect { |e| e[:blocker] if e[:blocked] == athlete }.compact
      end

      def people_requesting_to_follow(athlete)
        @data_store.requests.collect { |e| e[:requester] if e[:requested] == athlete }.compact
      end

      def follow_requested_by(athlete)
        @data_store.requests.collect { |e| e[:requested] if e[:requester] == athlete }.compact
      end
    end
  end
end
