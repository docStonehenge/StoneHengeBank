module StonehengeBank
  module Calculators
    describe MonthInterestEquivalency do
      let(:interest_rate) { double(:interest_rate, value: 0.15) }

      subject { described_class.new(interest_rate) }

      context 'as subclass of InterestEquivalency' do
        it { is_expected.to respond_to :transformed_rate }
        it { is_expected.to respond_to :equivalent_rate_power }
      end

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

      describe '#transformed_rate' do
        specify 'when rate period is monthly' do
          expect(interest_rate).to receive(:monthly?).and_return true

          expect(subject.transformed_rate).to eql 0.15
        end

        specify 'when rate period is quarterly' do
          expect(interest_rate).to receive(:monthly?).and_return false
          expect(subject).to receive(:equivalent_rate_power).and_return 1.0/3

          expect(subject.transformed_rate).to eql 0.04769
        end

        specify 'when rate period is semiannually' do
          expect(interest_rate).to receive(:monthly?).and_return false
          expect(subject).to receive(:equivalent_rate_power).and_return 1.0/6

          expect(subject.transformed_rate).to eql 0.02357
        end

        specify 'when rate period is annually' do
          expect(interest_rate).to receive(:monthly?).and_return false
          expect(subject).to receive(:equivalent_rate_power).and_return 1.0/12

          expect(subject.transformed_rate).to eql 0.01171
        end

        specify 'when rate period is daily' do
          expect(interest_rate).to receive(:monthly?).and_return false
          expect(subject).to receive(:equivalent_rate_power).and_return 30

          expect(subject.transformed_rate).to eql 65.21177
        end
      end
    end
  end
end
