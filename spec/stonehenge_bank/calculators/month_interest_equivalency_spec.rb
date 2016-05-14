module StonehengeBank
  module Calculators
    describe MonthInterestEquivalency do
      it_behaves_like 'an interest equivalency calculator'

      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        it 'returns the equivalent rate for annually period' do
          allow(interest_rate).to receive(:annually?).and_return true

          expect(subject.equivalent_rate_power).to eql 1.0/12
        end

        it 'returns the equivalent rate for semiannually period' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return true

          expect(subject.equivalent_rate_power).to eql 1.0/6
        end

        it 'returns the equivalent rate for quarterly period' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return false
          allow(interest_rate).to receive(:quarterly?).and_return true

          expect(subject.equivalent_rate_power).to eql 1.0/3
        end

        it 'returns the equivalent rate for daily period' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return false
          allow(interest_rate).to receive(:quarterly?).and_return false
          allow(interest_rate).to receive(:daily?).and_return true

          expect(subject.equivalent_rate_power).to eql 30
        end
      end

      describe '#matches_rate_period?' do
        it 'checks the rate period if it is monthly' do
          expect(interest_rate).to receive(:monthly?)

          subject.matches_rate_period?
        end
      end
    end
  end
end
