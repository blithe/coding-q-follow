require 'strava/follow'

describe Strava::Follow do
  context 'Bob follows Joe' do
    before do
      # Establish follows relationship between Bob and Joe here
    end

    it 'Joe should be one of the people Bob follows' do
      # implement specs
    end

    it 'Bob should not be one of the people Joe follows' do
    end


    it 'Bob should be one of the people following Joe' do

    end

    it 'Joe should not be one of the people following Bob' do

    end
  end

  context 'Blocking' do
    context 'Mary blocks Bob' do
      before do
        # Establish block relationship between Mary and Bob
      end

      it 'Joe should be one of the people Mary blocks' do

      end

      it 'Mary should not be one of the people Joe blocks' do

      end

      it 'Mary should be one of the people blocking Joe' do

      end

      it 'Joe should not be one of the people blocking Mary' do

      end

      context 'Bob attempts to follow Mary' do
        before do
          # Bob attempts to follow Mary
        end

        it 'Mary should not be one of the people Bob follows' do
          # implement specs
        end

        it 'Bob should not be one of the people following Mary' do

        end
      end
    end

    context 'Bob follows Mary, then Mary blocks Bob' do
      before do
        # Establish follows relationship between Bob and Mary here
        # Establish block relationship between Mary and Bob
      end

      it 'Mary should not be one of the people Bob follows' do

      end

      it 'Bob should not be one of the people following Mary' do

      end
    end
  end

  context 'Bob asks to follow Joe' do
    # Joe must approve any request to follow him.
    before do
      # Establish request to follow relationship between Bob and Joe here
    end

    it 'Joe should not be one of the people Bob follows' do
      # implement specs
    end

    it 'Bob should be one of the people who has requested to follow Joe' do

    end

    it 'Bob should not be one of the people following Joe' do

    end

    it 'Joe should be one of the people Bob has requested to follow' do

    end

    context "Joe approves Bob's request to follow" do
      before do
        # approve Bob's request
      end

      it 'Joe should be one of the people Bob follows' do
        # implement specs
      end

      it 'Bob should not be one of the people who has requested to follow Joe' do

      end

      it 'Bob should be one of the people following Joe' do

      end

      it 'Joe should not be one of the people Bob has requested to follow' do

      end
    end

    context "Joe deny's Bob's request to follow" do
      before do
        # deny Bob's request
      end

      it 'Joe should not be one of the people Bob follows' do
        # implement specs
      end

      it 'Bob should not be one of the people who has requested to follow Joe' do

      end

      it 'Bob should not be one of the people following Joe' do

      end

      it 'Joe should not be one of the people Bob has requested to follow' do

      end
    end

  end
end
