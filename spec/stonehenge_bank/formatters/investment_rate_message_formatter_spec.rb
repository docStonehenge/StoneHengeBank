module StonehengeBank
  module Formatters
    describe InvestmentRateMessageFormatter do
      let(:investment)  { double(:investment, present_value: 100.0, future_value: 1000.0) }
      let(:message)     { double(:message) }

      subject do
        Formatters::BaseMessageFormatter.new(
          investment, with_message: message
        ).for_type(:investment_rate)
      end

      describe '#calculation_with_message equivalency, period' do
        it 'returns investment rate calculation with a formatted message' do
          expect(investment).to receive(
                                  :calculated_investment_rate
                                ).with(24).and_return 3.45

          expect(message).to receive(:has_value).with('present value', 100.0, separator: ',')
          expect(message).to receive(:has_value).with('future value', 1000.0, separator: ',')
          expect(message).to receive(:with_period).with(:month, 24)

          expect(message).to receive(:with_rate).with(3.45, separator: '.').
                              and_return(
                                'An investment has present value of $100.0, has future value of $1000.0, on a period of 24 month(s), with an interest rate of 3.45%.'
                              )

          expect(
            subject.calculation_with_message(:month, 24)
          ).to eql 'An investment has present value of $100.0, has future value of $1000.0, on a period of 24 month(s), with an interest rate of 3.45%.'
        end
      end
    end
  end
end
