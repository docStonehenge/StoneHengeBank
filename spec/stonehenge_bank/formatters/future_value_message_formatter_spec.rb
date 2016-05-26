module StonehengeBank
  module Formatters
    describe FutureValueMessageFormatter do
      let(:investment)   { double(:investment) }
      let(:equivalency)  { Calculators::YearInterestEquivalency.new(double) }

      subject { described_class.new(investment) }

      describe '#calculation_with_message equivalency, period' do
        it 'returns the future value calculation with a formatted explanation message' do
          expect(investment).to receive(:present_value).and_return 1000.0
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248
          expect(investment).to receive(
                                  :calculated_future_value
                                ).with(equivalency, 2).and_return 1500.0

          expect(
            subject.calculation_with_message(equivalency, 2)
          ).to eql "An investment with present value of $1000.0, an interest rate of 12.48% on a period of 2 year(s), returns a future value of $1500.0."
        end
      end
    end
  end
end
