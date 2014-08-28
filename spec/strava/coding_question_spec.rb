require 'strava'
require 'strava/coding_question'

describe Strava::CodingQuestion do
  let(:joe) { Strava::Models::Athlete.new(1, 'joe', 'foo', Date.new(2000, 1, 1)) }
  let(:bob) { Strava::Models::Athlete.new(2, 'bob', 'bar', Date.new(1980, 8, 8)) }
  let(:mary){ Strava::Models::Athlete.new(3, 'mary', 'lamb', Date.new(1980, 10, 8)) }
  let(:store) { Strava::DataStore.new }
  let(:service) { Strava::Services::FollowService.new(store) }

  before do
    store.add_athlete(joe)
    store.add_athlete(bob)
    store.add_athlete(mary)
  end

  context 'Bob follows Joe,' do
    before do
      # Establish follows relationship between Bob and Joe here
      store.add_follow(bob, joe)
    end

    it 'Joe should be one of the people Bob follows' do
      expect(service.people_followed_by(bob)).to include(joe)
    end

    it 'Bob should not be one of the people Joe follows' do
      expect(service.people_followed_by(joe)).to_not include(bob)
    end


    it 'Bob should be one of the people following Joe' do
      expect(service.people_following(joe)).to include(bob)
    end

    it 'Joe should not be one of the people following Bob' do
      expect(service.people_following(bob)).to_not include(joe)
    end
  end

  context 'Blocking:' do
    context 'when Mary blocks Joe,' do
      before do
        # Establish block relationship between Mary and Joe
        store.add_block(mary, joe)
      end

      it 'Joe should be one of the people Mary blocks' do
        expect(service.people_blocked_by(mary)).to include(joe)
      end

      it 'Mary should not be one of the people Joe blocks' do
        expect(service.people_blocked_by(joe)).to_not include(mary)
      end

      it 'Mary should be one of the people blocking Joe' do
        expect(service.people_blocking(joe)).to include(mary)
      end

      it 'Joe should not be one of the people blocking Mary' do
        expect(service.people_blocking(mary)).to_not include(joe)
      end

      context 'when Joe attempts to follow Mary,' do
        before do
          # Joe attempts to follow Mary
          store.add_follow(joe, mary)
        end

        it 'Mary should not be one of the people Joe follows' do
          expect(service.people_followed_by(joe)).to_not include(mary)
        end

        it 'Joe should not be one of the people following Mary' do
          expect(service.people_following(mary)).to_not include(joe)
        end
      end
    end

    context 'Joe follows Mary, then Mary blocks Joe' do
      before do
        # Establish follows relationship between Joe and Mary here
        store.add_follow(joe, mary)
        # Establish block relationship between Mary and Joe
        store.add_block(mary, joe)
      end

      it 'Mary should not be one of the people Joe follows' do
        expect(service.people_followed_by(joe)).to_not include(mary)
      end

      it 'Joe should not be one of the people following Mary' do
        expect(service.people_following(mary)).to_not include(joe)
      end
    end
  end

  context 'Bob asks to follow Joe' do
    # Joe must approve any request to follow him.
    before do
      # Establish request to follow relationship between Bob and Joe here
      store.add_request(bob, joe)
    end

    it 'Joe should not be one of the people Bob follows' do
      expect(service.people_followed_by(bob)).to_not include(joe)
    end

    it 'Bob should be one of the people who has requested to follow Joe' do
      expect(service.people_requesting_to_follow(joe)).to include(bob)
    end

    it 'Bob should not be one of the people following Joe' do
      expect(service.people_following(joe)).to_not include(bob)
    end

    it 'Joe should be one of the people Bob has requested to follow' do
      expect(service.follow_requested_by(bob)).to include(joe)
    end

    context "Joe approves Bob's request to follow" do
      before do
        # approve Bob's request
        store.approve_request(joe, bob)
      end

      it 'Joe should be one of the people Bob follows' do
        expect(service.people_followed_by(bob)).to include(joe)
      end

      it 'Bob should not be one of the people who has requested to follow Joe' do
        expect(service.people_requesting_to_follow(joe)).to_not include(bob)
      end

      it 'Bob should be one of the people following Joe' do
        expect(service.people_following(joe)).to include(bob)
      end

      it 'Joe should not be one of the people Bob has requested to follow' do
        expect(service.follow_requested_by(bob)).to_not include(joe)
      end
    end

    context "Joe deny's Bob's request to follow" do
      before do
        # deny Bob's request
        store.deny_request(joe, bob)
      end

      it 'Joe should not be one of the people Bob follows' do
        expect(service.people_followed_by(bob)).to_not include(joe)
      end

      it 'Bob should not be one of the people who has requested to follow Joe' do
        expect(service.people_requesting_to_follow(joe)).to_not include(bob)
      end

      it 'Bob should not be one of the people following Joe' do
        expect(service.people_following(joe)).to_not include(bob)
      end

      it 'Joe should not be one of the people Bob has requested to follow' do
        expect(service.follow_requested_by(bob)).to_not include(joe)
      end
    end

  end
end
