module StonehengeBank
  module Calculators
    describe TrimesterInterestEquivalency do
      it_behaves_like 'an interest equivalency calculator'

      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        specify 'when rate period is annually' do
          expect(subject.anually_rate_power).to eql 0.25
        end

        specify 'when rate period is semiannually' do
          expect(subject.semiannually_rate_power).to eql 0.5
        end

        specify 'when rate period is monthly' do
          expect(subject.monthly_rate_power).to eql 3
        end

        specify 'when rate period is daily' do
          expect(subject.daily_rate_power).to eql 90
        end
      end

      describe '#matches_rate_period?' do
        it 'checks rate period if it is quarterly' do
          expect(interest_rate).to receive(:quarterly?).and_return(true)
          expect(subject.matches_rate_period?).to be true
        end
      end
    end
  end
end
