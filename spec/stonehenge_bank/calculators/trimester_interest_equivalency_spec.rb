module StonehengeBank
  module Calculators
    describe TrimesterInterestEquivalency do
      let(:interest_rate) { double(:interest_rate, value: 0.025) }

      subject { described_class.new(interest_rate) }

      context 'as subclass of InterestEquivalency' do
        it { is_expected.to respond_to :transformed_rate }
        it { is_expected.to respond_to :equivalent_rate_power }
      end

      describe '#equivalent_rate_power' do
        specify 'when rate period is annually' do
          allow(interest_rate).to receive(:annually?).and_return true

          expect(subject.equivalent_rate_power).to eql 0.25
        end

        specify 'when rate period is semiannually' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return true

          expect(subject.equivalent_rate_power).to eql 0.5
        end

        specify 'when rate period is monthly' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return false
          allow(interest_rate).to receive(:monthly?).and_return true

          expect(subject.equivalent_rate_power).to eql 3
        end
      end

      describe '#transformed_rate' do
        it 'returns the interest rate value if rate period is quarterly' do
          expect(interest_rate).to receive(:quarterly?).and_return true

          expect(subject.transformed_rate).to eql 0.025
        end

        it 'calculates the rate based on the equivalent power for a different period' do
          expect(interest_rate).to receive(:quarterly?).and_return false
          allow(subject).to receive(:equivalent_rate_power).and_return 3

          expect(subject.transformed_rate).to eql 0.07689
        end
      end
    end
  end
end
