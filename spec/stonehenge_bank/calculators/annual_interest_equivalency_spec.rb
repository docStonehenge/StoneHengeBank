require 'stonehenge_bank/calculators/annual_interest_equivalency'

module StonehengeBank
  module Calculators
    describe AnnualInterestEquivalency do
      let(:interest_rate) { double(:interest_rate, value: 0.006) }

      subject { described_class.new(interest_rate) }

      context 'as subclass of InterestEquivalency' do
        it { is_expected.to respond_to :transformed_rate }
      end

      describe '#transformed_rate' do
        before do
          allow(interest_rate).to receive(:annually?).and_return(@annually)
        end

        specify 'when interest rate period is monthly' do
          @annually = false
          expect(interest_rate).to receive(:monthly?).and_return(true)

          expect(subject.transformed_rate).to eql(7.44)
        end

        specify 'when interest rate period is semiannually' do
          @annually = false
          expect(interest_rate).to receive(:monthly?).and_return(false)
          expect(interest_rate).to receive(:semiannually?).and_return(true)

          expect(subject.transformed_rate).to eql(1.20)
        end

        specify 'when interest rate period is quarterly' do
          @annually = false
          expect(interest_rate).to receive(:monthly?).and_return(false)
          expect(interest_rate).to receive(:semiannually?).and_return(false)
          expect(interest_rate).to receive(:quarterly?).and_return(true)

          expect(subject.transformed_rate).to eql(2.42)
        end

        specify 'when interest rate period is annually' do
          expect(interest_rate).to receive(:annually?).and_return(true)

          expect(subject.transformed_rate).to eql(0.006)
        end
      end
    end
  end
end
