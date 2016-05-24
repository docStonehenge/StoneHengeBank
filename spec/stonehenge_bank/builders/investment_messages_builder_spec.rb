module StonehengeBank
  module Builders
    describe InvestmentMessagesBuilder do
      let(:investment)  { double(:investment) }
      let(:equivalency) { StonehengeBank::Calculators::YearInterestEquivalency.new(double) }

      subject { described_class.new(investment) }

      describe '#calculated_future_value_message equivalency, period' do
        it 'returns a formatted message for investment calculated future value' do
          allow(investment).to receive(:present_value).and_return 1000.0
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248
          expect(investment).to receive(:calculated_future_value).with(equivalency, 2).
                                 and_return 1500.0

          expect(
            subject.calculated_future_value_message(equivalency, 2)
          ).to eql "An investment with present value of $1000.0, an interest rate of 12.48 and a period of 2 year(s) returns a future value of $1500.0."
        end
      end
    end
  end
end
