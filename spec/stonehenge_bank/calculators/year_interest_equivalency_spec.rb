module StonehengeBank
  module Calculators
    describe YearInterestEquivalency do
      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      it_behaves_like 'an interest equivalency calculator'

      describe '#equivalent_rate_power' do
        it 'returns the equivalent power for monthly period' do
          expect(subject.monthly_rate_power).to eql 12
        end

        it 'returns the equivalent power for quarterly period' do
          expect(subject.quarterly_rate_power).to eql 4
        end

        it 'returns the equivalent power for semiannually period' do
          expect(subject.semiannually_rate_power).to eql 2
        end

        it 'returns the equivalent power for daily period' do
          expect(subject.daily_rate_power).to eql 360
        end
      end

      describe '#matches_rate_period?' do
        it 'checks rate period to see if it is annually' do
          expect(interest_rate).to receive(:annually?).and_return(true)
          expect(subject.matches_rate_period?).to be true
        end
      end
    end
  end
end
