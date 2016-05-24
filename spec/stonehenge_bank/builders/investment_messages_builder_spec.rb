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
            subject.calculated_future_value_with_message(equivalency, 2)
          ).to eql "An investment with present value of $1000.0, an interest rate of 12.48 and a period of 2 year(s) returns a future value of $1500.0."
        end

        it 'rescues investment errors and prompts a warning message' do
          allow(investment).to receive(:present_value).and_return nil
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248

          expect(investment).to receive(:calculated_future_value).with(equivalency, 2).
                                 and_raise(StonehengeBank::Resources::Investment::UncalculableInvestmentValueError, 'Foo')

          expect(
            subject.calculated_future_value_with_message(equivalency, 2)
          ).to eql "Cannot elaborate a message because of an error on the investment calculation: Foo. Please, check the values needed to be able to call the calculation again."
        end
      end

      describe '#calculated_present_value_message equivalency, period' do
        it 'returns a formatted message for investment calculated present value' do
          allow(investment).to receive(:future_value).and_return(1000.0)
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248

          expect(investment).to receive(:calculated_present_value).with(equivalency, 2).
                                 and_return 740.0

          expect(
            subject.calculated_present_value_with_message(equivalency, 2)
          ).to eql "An investment with future value of $1000.0, an interest rate of 12.48 and a period of 2 year(s) has to have a present value of $740.0."
        end

        it 'rescues investment errors and prompts a warning message' do
          allow(investment).to receive(:future_value).and_return nil
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248

          expect(investment).to receive(:calculated_present_value).with(equivalency, 2).
                                 and_raise(StonehengeBank::Resources::Investment::UncalculableInvestmentValueError, 'Foo')

          expect(
            subject.calculated_present_value_with_message(equivalency, 2)
          ).to eql "Cannot elaborate a message because of an error on the investment calculation: Foo. Please, check the values needed to be able to call the calculation again."
        end

        describe '#calculated_investment_rate_message period_kind, quantity' do
          it 'returns a formatted message for investment calculated rate' do
            allow(investment).to receive(:present_value).and_return(800.0)
            allow(investment).to receive(:future_value).and_return(1000.0)

            expect(investment).to receive(:calculated_investment_rate).
                                   with(:year, 2).and_return 0.1248

            expect(
              subject.calculated_investment_rate_with_message(:year, 2)
            ).to eql "An investment with present value of $800.0, an interest rate of 12.48 and a period of 2 year(s) returns a future value of $1000.0."
          end

          it 'rescues investment errors and prompts a warning message' do
            allow(investment).to receive(:present_value).and_return 800.0
            allow(investment).to receive(:future_value).and_return nil

            expect(investment).to receive(:calculated_investment_rate).
                                   with(:year, 2).
                                   and_raise(
                                     StonehengeBank::Resources::Investment::UncalculableInvestmentValueError,
                                     'Foo'
                                   )

            expect(
              subject.calculated_investment_rate_with_message(:year, 2)
            ).to eql "Cannot elaborate a message because of an error on the investment calculation: Foo. Please, check the values needed to be able to call the calculation again."
          end
        end

        describe '#calculated_investment_period_with_message equivalency' do
          it 'returns a formatted message for investment period calculation' do
            allow(investment).to receive(:present_value).and_return(800.0)
            allow(investment).to receive(:future_value).and_return(1000.0)
            allow(equivalency).to receive(:transformed_rate).and_return 0.1248

            expect(investment).to receive(:calculated_investment_period).
                                   with(equivalency).and_return 2

            expect(
              subject.calculated_investment_period_with_message(equivalency)
            ).to eql "An investment with present value of $800.0, an interest rate of 12.48 and a period of 2 year(s) returns a future value of $1000.0."
          end

          it 'rescues investment calculation error and prompts warning message' do
            allow(investment).to receive(:present_value).and_return nil
            allow(investment).to receive(:future_value).and_return(1000.0)
            allow(equivalency).to receive(:transformed_rate).and_return 0.1248

            expect(investment).to receive(:calculated_investment_period).
                                   with(equivalency).
                                   and_raise(
                                     StonehengeBank::Resources::Investment::UncalculableInvestmentValueError,
                                     'Foo'
                                   )

            expect(
              subject.calculated_investment_period_with_message(equivalency)
            ).to eql "Cannot elaborate a message because of an error on the investment calculation: Foo. Please, check the values needed to be able to call the calculation again."
          end
        end
      end
    end
  end
end
