module StonehengeBank
  module Calculators
    class Payback
      def initialize(payback_return)
        @payback_return, @accumulated_cash_flow = payback_return, 0
      end

      def calculate(cash_flow)
        cash_flow.investments.each_with_index do |investment, index|
          period = index + 1

          accumulate_cash_flow_return_on investment, period
          return period if (@accumulated_cash_flow - cash_flow.cost) >= 0
        end

        nil
      end

      private

      def accumulate_cash_flow_return_on(investment, period)
        with_cash_flow_calculation_handling_for(investment) do
          @accumulated_cash_flow += @payback_return.return_value_from(
            investment, period
          )
        end
      end

      def with_cash_flow_calculation_handling_for(investment)
        if investment.future_value.nil?
          raise Resources::CashFlowError,
                'An error occurred on Payback calculation due to cash flow inconsistencies.'
        end

        yield
      end
    end
  end
end
