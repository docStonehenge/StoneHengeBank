module StonehengeBank
  module Calculators
    describe SemesterInterestEquivalency do
      it_behaves_like 'an interest equivalency calculator'

      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        specify 'when rate period is annually' do
          expect(subject.annually_rate_power).to eql 0.5
        end

        specify 'when rate period is quarterly' do
          expect(subject.quarterly_rate_power).to eql 2
        end

        specify 'when rate period is monthly' do
          expect(subject.monthly_rate_power).to eql 6
        end

        specify 'when rate period is daily' do
          expect(subject.daily_rate_power).to eql 180
        end
      end

      describe '#matches_rate_period?' do
        it 'check the rate period if it is semiannually' do
          expect(interest_rate).to receive(:semiannually?).and_return(true)
          expect(subject.matches_rate_period?).to be true
        end
      end
    end
  end
end
