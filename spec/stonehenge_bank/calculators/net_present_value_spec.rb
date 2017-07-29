module StonehengeBank
  module Calculators
    describe NetPresentValue do
      let(:cash_flow)                 { double(:cash_flow, cost: 3_000, investments: [investment_1, investment_2]) }
      let(:investment_1)              { double(:investment) }
      let(:investment_2)              { double(:investment) }
      let(:year_interest_equivalency) { double(:year_interest_equivalency) }

      describe '#calculate cash_flow, using_equivalency:' do
        it 'calculates the net present value of a project with determined cash flow' do
          expect(investment_1).to receive(
                                    :calculated_present_value
                                  ).with(year_interest_equivalency, 1).and_return 1100.0

          expect(investment_2).to receive(
                                    :calculated_present_value
                                  ).with(year_interest_equivalency, 2).and_return 1200.0

          expect(
            subject.calculate(cash_flow, using_equivalency: year_interest_equivalency)
          ).to eql(-700.0)
        end

        it 'raises error when cash flow calculation runs on error' do
          expect(investment_1).to receive(
                                  :calculated_present_value
                                ).with(year_interest_equivalency, 1).and_raise(UncalculableInvestmentValueError)

          expect {
            subject.calculate(cash_flow, using_equivalency: year_interest_equivalency)
          }.to raise_error(Resources::CashFlowError, 'An error occurred on Net Present Value calculation due to cash flow inconsistencies.')
        end
      end
    end
  end
end
