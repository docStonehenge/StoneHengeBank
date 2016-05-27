module StonehengeBank
  module Formatters
    describe FutureValueMessageFormatter do
      let(:investment)   { double(:investment, present_value: 1000.0) }
      let(:message)      { double(:message) }
      let(:equivalency)  { Calculators::YearInterestEquivalency.new(double) }

      subject do
        Formatters::BaseMessageFormatter.new(
          investment, with_message: message
        ).for_type(:future_value)
      end

      describe '#calculation_with_message equivalency, period' do
        it 'returns the future value calculation with a formatted explanation message' do
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248

          expect(investment).to receive(
                                  :calculated_future_value
                                ).with(equivalency, 2).and_return 1500.0

          expect(message).to receive(:with_value).with('present value', 1000.0)
          expect(message).to receive(:with_rate).with(12.48)
          expect(message).to receive(:with_period).with('year', 2)

          expect(message).to receive(:returns_value).
                              with('future value', 1500.0).
                              and_return 'An investment with present value of $1000.0, with an interest rate of 12.48, on a period of 2 year(s), returns a future value of $1500.0.'

          expect(
            subject.calculation_with_message(equivalency, 2)
          ).to eql 'An investment with present value of $1000.0, with an interest rate of 12.48, on a period of 2 year(s), returns a future value of $1500.0.'
        end
      end
    end
  end
end
