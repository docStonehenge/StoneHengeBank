module StonehengeBank
  module Builders
    describe InterestRateBuilder do
      subject { described_class.new('6,31% monthly') }

      it 'raises error if is not possible to parse string' do
        expect {
          described_class.new('foobar')
        }.to raise_error(
               InterestRateBuilder::RateNotParseable, "Interest rate used is not parseable."
             )
      end

      it 'raises error when period sent is nil' do
        expect {
          described_class.new('3.89% ')
        }.to raise_error(
               InterestRateBuilder::RateNotParseable, "Interest rate used is not parseable."
             )

        expect {
          described_class.new('3.89%')
        }.to raise_error(
               InterestRateBuilder::RateNotParseable, "Interest rate used is not parseable."
             )
      end

      it 'can read string without percent symbol' do
        expect { described_class.new('6 semiannually') }.not_to raise_error
      end

      it 'can read string separated by a comma' do
        expect { described_class.new('6, semiannually') }.not_to raise_error
      end

      it 'can read mistyped interest rate strings' do
        expect { described_class.new('6%semiannually') }.not_to raise_error
      end

      describe '#construct_interest_rate' do
        it 'returns a new interest rate with value and period' do
          result = subject.construct_interest_rate

          expect(result).to be_an_instance_of Resources::InterestRate
          expect(result.value).to eql(0.0631)
          expect(result.period).to eql('monthly')
        end

        it 'raises error if interest rate period is not valid' do
          subject = described_class.new('3.89 foo')

          expect {
            subject.construct_interest_rate
          }.to raise_error(Resources::InterestRate::InvalidRatePeriodError)
        end
      end
    end
  end
end
