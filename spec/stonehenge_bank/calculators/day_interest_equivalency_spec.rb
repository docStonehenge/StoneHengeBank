module StonehengeBank
  module Calculators
    describe DayInterestEquivalency do
      it_behaves_like 'an interest equivalency calculator'

      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        specify 'when rate period is annually' do
          expect(subject.annually_rate_power).to eql 1.0 / 360
        end

        specify 'when rate period is semiannually' do
          expect(subject.semiannually_rate_power).to eql 1.0 / 180
        end

        specify 'when rate period is quarterly' do
          expect(subject.quarterly_rate_power).to eql 1.0 / 90
        end

        specify 'when rate period is monthly' do
          expect(subject.monthly_rate_power).to eql 1.0 / 30
        end
      end

      describe '#matches_rate_period?' do
        it 'checks rate period if it is daily' do
          expect(interest_rate).to receive(:daily?).and_return(true)
          expect(subject.matches_rate_period?).to be true
        end
      end
    end
  end
end
