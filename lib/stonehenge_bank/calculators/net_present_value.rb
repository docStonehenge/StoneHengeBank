module StonehengeBank
  module Calculators
    class NetPresentValue
      def calculate(cash_flow, using_equivalency:)
        cash_flow.investments.each_with_index.inject(0) do |sum, (investment, index)|
          sum += investment.calculated_present_value(using_equivalency, index+1)
        end - cash_flow.cost

      rescue UncalculableInvestmentValueError
        raise CashFlowCalculationError,
              'An error occurred on Net Present Value calculation due to cash flow inconsistencies.'
      end
    end
  end
end
