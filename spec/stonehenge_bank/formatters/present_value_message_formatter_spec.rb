module StonehengeBank
  module Formatters
    describe PresentValueMessageFormatter do
      let(:investment)  { double(:investment, future_value: 1500.0) }
      let(:message)     { double(:message) }
      let(:equivalency) { Calculators::YearInterestEquivalency.new(double) }

      subject do
        Formatters::BaseMessageFormatter.new(
          investment, with_message: message
        ).for_type(:present_value)
      end

      describe '#calculation_with_message equivalency, period' do
        it 'returns investment present value calculation inside an explanation message' do
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248

          expect(investment).to receive(
                                  :calculated_present_value
                                ).with(equivalency, 2).and_return 1000.0

          expect(message).to receive(:with_value).with('future value', 1500.0)
          expect(message).to receive(:with_rate).with(12.48)
          expect(message).to receive(:with_period).with('year', 2)

          expect(message).to receive(:has_value).
                              with('present value', 1000.0).
                              and_return 'An investment with future value of $1500.0, an interest rate of 12.48, on a period of 2 year(s), has present value of $1000.0.'

          expect(
            subject.calculation_with_message(equivalency, 2)
          ).to eql 'An investment with future value of $1500.0, an interest rate of 12.48, on a period of 2 year(s), has present value of $1000.0.'
        end
      end
    end
  end
end
