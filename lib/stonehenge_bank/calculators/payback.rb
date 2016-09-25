module StonehengeBank
  module Calculators
    class Payback
      def calculate(cash_flow)
        sum = 0

        cash_flow.investments.each_with_index do |investment, index|
          with_cash_flow_calculation_handling_for(investment) do
            sum += investment.future_value
            return (index + 1) if (sum - cash_flow.cost) >= 0
          end
        end

        nil
      end

      private

      def with_cash_flow_calculation_handling_for(investment)
        if investment.future_value.nil?
          raise CashFlowCalculationError,
                'An error occurred on Payback calculation due to cash flow inconsistencies.'
        end

        yield
      end
    end
  end
end
