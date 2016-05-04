module StonehengeBank
  module Parsers
    describe InterestRateParser do
      subject { described_class.new('6% monthly') }

      describe '#construct_interest_rate' do
        it 'returns a new interest rate with value and period' do
          result = subject.construct_interest_rate

          expect(result).to be_an_instance_of Resources::InterestRate
          expect(result.value).to eql(0.06)
          expect(result.period).to eql('monthly')
        end
      end
    end
  end
end
