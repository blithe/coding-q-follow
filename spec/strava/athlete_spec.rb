require 'strava'

describe Strava::Models::Athlete do
  let(:joe) { Strava::Models::Athlete.new(1, 'joe', 'foo', Date.new(1990, 9, 1)) }

  context '#age' do

    it 'should get the age when the birthday has passed' do
      today = Date.new(2014,10,1)
      expect(joe.age(today)).to eql(24)
    end

    it 'should get the age when the birthday has not yet passed' do
      today = Date.new(2014,5,1)
      expect(joe.age(today)).to eql(23)
    end

    it "should get the age on the athlete's birthday" do
      today = Date.new(2014, 9, 1)
      expect(joe.age(today)).to eql(24)
    end
  end
end
