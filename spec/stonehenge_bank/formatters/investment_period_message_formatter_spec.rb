module StonehengeBank
  module Formatters
    describe InvestmentPeriodMessageFormatter do
      let(:investment)  { double(:investment, present_value: 1000.0, future_value: 1500.0) }
      let(:message)     { double(:message) }
      let(:equivalency) { Calculators::MonthInterestEquivalency.new(double) }

      subject do
        Formatters::BaseMessageFormatter.new(
          investment, with_message: message
        ).for_type(:investment_period)
      end

      describe '#calculation_with_message equivalency, period' do
        it 'returns a message with investment period calculation' do
          allow(equivalency).to receive(:transformed_rate).and_return 0.0094

          expect(investment).to receive(
                                  :calculated_investment_period
                                ).with(equivalency).and_return 36

          expect(message).to receive(:has_value).with('present value', 1000.0, separator: ', ')
          expect(message).to receive(:has_value).with('future value', 1500.0, separator: ', ')
          expect(message).to receive(:with_rate).with(0.94)

          expect(message).to receive(:with_period).
                              with('month', 36, separator: '.').
                              and_return(
                                'An investment has present value of $1000.0, has future value of $1500.0, with an interest rate of 0.94%, on a period of 36 month(s).'
                              )

          expect(
            subject.calculation_with_message(equivalency)
          ).to eql 'An investment has present value of $1000.0, has future value of $1500.0, with an interest rate of 0.94%, on a period of 36 month(s).'
        end
      end
    end
  end
end
