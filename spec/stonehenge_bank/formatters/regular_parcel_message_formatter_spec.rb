module StonehengeBank
  module Formatters
    describe RegularParcelMessageFormatter do
      let(:investment)  { double(:investment, present_value: 1000.0, future_value: 1500.0) }
      let(:message)     { double(:message) }
      let(:equivalency) { Calculators::MonthInterestEquivalency.new(double) }

      subject do
        Formatters::BaseMessageFormatter.new(
          investment, with_message: message
        ).for_type(:regular_parcel)
      end

      describe '#calculation_with_message equivalency, period' do
        it 'returns regular parcel calculation in a formatted message' do
          allow(equivalency).to receive(:transformed_rate).and_return 0.0945

          expect(investment).to receive(
                                  :calculated_regular_parcel
                                ).with(equivalency, 24).and_return 150.0

          expect(message).to receive(:with_value).with('present value', 1000.0)
          expect(message).to receive(:has_value).with('future value', 1500.0, separator: ',')
          expect(message).to receive(:with_rate).with(9.45)
          expect(message).to receive(:with_period).with('month', 24)

          expect(message).to receive(:with_value).
                              with('regular parcel', 150.0, separator: '.').
                              and_return(
                                'An investment with present value of $1000.0, has future value of $1500.0, with an interest rate of 9.45%, on a period of 24 month(s), with a regular parcel of $150.0.'
                              )

          expect(
            subject.calculation_with_message(equivalency, 24)
          ).to eql 'An investment with present value of $1000.0, has future value of $1500.0, with an interest rate of 9.45%, on a period of 24 month(s), with a regular parcel of $150.0.'
        end
      end
    end
  end
end
