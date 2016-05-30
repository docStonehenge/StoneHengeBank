module StonehengeBank
  module Decorators
    describe InvestmentDecorator do
      let(:investment)  { double(:investment) }
      let(:formatter)   { double(:formatter) }
      let(:equivalency) { double(:equivalency) }

      subject { described_class.new(investment) }

      describe '#method_missing method_name, *args' do
        it 'calls method on investment if it responds to the message' do
          expect(investment).to receive(:calculated_future_value).with(equivalency, 24)
          subject.calculated_future_value(equivalency, 24)
        end

        it 'instantiates the proper formatter and calls calculation on it' do
          expect(
            Formatters::BaseMessageFormatter
          ).to receive(:new).with(investment).and_return(formatter)

          expect(formatter).to receive(:for_type).with('investment_rate').and_return(formatter)
          expect(formatter).to receive(:calculation_with_message).with(24)
          subject.calculated_investment_rate_with_message(24)
        end
      end
    end
  end
end
