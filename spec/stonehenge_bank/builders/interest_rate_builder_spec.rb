module StonehengeBank
  module Builders
    describe InterestRateBuilder do
      subject { described_class.new('6,31% monthly') }

      it 'raises error if is not possible to parse string' do
        expect {
          described_class.new('foobar')
        }.to raise_error(
               InterestRateBuilder::RateNotParseable, "The string typed is not parseable."
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
      end
    end
  end
end
