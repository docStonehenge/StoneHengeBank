module StonehengeBank
  module Decorators
    describe InvestmentDecorator do
      let(:investment)  { double(:investment) }
      let(:formatter)   { double(:formatter) }
      let(:equivalency) { double(:equivalency) }

      subject { described_class.new(investment) }

      describe '#method_missing method_name, *args' do
        context "when method name contains 'with_message' suffix" do
          context 'when formatter exists' do
            it 'instantiates the proper formatter and calls calculation on it' do
              expect(Formatters).to receive(:const_defined?).
                                     with('InvestmentRateMessageFormatter').and_return true

              expect(
                Formatters::BaseMessageFormatter
              ).to receive(:new).with(investment).and_return(formatter)

              expect(formatter).to receive(:for_type).with('investment_rate').and_return(formatter)
              expect(formatter).to receive(:calculation_with_message).with(24)
              subject.calculated_investment_rate_with_message(24)
            end
          end

          context 'when formatter does not exist' do
            it 'raises NoMethodError' do
              expect(Formatters).to receive(:const_defined?).
                                     with('FooMessageFormatter').and_return false

              expect(
                Formatters::BaseMessageFormatter
              ).not_to receive(:new).with(any_args)

              expect {
                subject.calculated_foo_with_message(24)
              }.to raise_error NoMethodError
            end
          end
        end

        context "when method name just contains '_value' suffix" do
          it 'calls method on investment if it responds to the message' do
            expect(investment).to receive(:calculated_future_value).with(equivalency, 24)
            subject.calculated_future_value(equivalency, 24)
          end
        end

        it 'raises NoMethodError for nonexistent methods on investment' do
          expect {
            subject.calculated_foo_value(equivalency, 2)
          }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
