module StonehengeBank
  module Calculators
    describe AnnualInterestEquivalency do
      let(:interest_rate) { double(:interest_rate, value: 0.006) }

      subject { described_class.new(interest_rate) }

      context 'as a subclass of InterestEquivalency' do
        it { is_expected.to respond_to :transformed_rate }
        it { is_expected.to respond_to :equivalent_rate_power }
      end

      describe '#equivalent_rate_power' do
        it 'returns the equivalent power for monthly period' do
          allow(interest_rate).to receive(:monthly?).and_return true

          expect(subject.equivalent_rate_power).to eql 12
        end

        it 'returns the equivalent power for quarterly period' do
          allow(interest_rate).to receive(:monthly?).and_return false
          allow(interest_rate).to receive(:quarterly?).and_return true

          expect(subject.equivalent_rate_power).to eql 4
        end

        it 'returns the equivalent power for semiannually period' do
          allow(interest_rate).to receive(:monthly?).and_return false
          allow(interest_rate).to receive(:quarterly?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return true

          expect(subject.equivalent_rate_power).to eql 2
        end
      end

      describe '#transformed_rate' do
        before do
          allow(interest_rate).to receive(:annually?).and_return(@annually)
        end

        specify 'when interest rate period is monthly' do
          @annually = false
          expect(subject).to receive(:equivalent_rate_power).and_return 12

          expect(subject.transformed_rate).to eql(0.07442)
        end

        specify 'when interest rate period is semiannually' do
          @annually = false
          expect(subject).to receive(:equivalent_rate_power).and_return 2

          expect(subject.transformed_rate).to eql 0.01204
        end

        specify 'when interest rate period is quarterly' do
          @annually = false
          expect(subject).to receive(:equivalent_rate_power).and_return 4

          expect(subject.transformed_rate).to eql(0.02422)
        end

        specify 'when interest rate period is annually' do
          expect(interest_rate).to receive(:annually?).and_return(true)
          expect(subject).not_to receive(:equivalent_rate_power)

          expect(subject.transformed_rate).to eql(0.006)
        end
      end
    end
  end
end
