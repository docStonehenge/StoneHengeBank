module StonehengeBank
  module Resources
    class NetPresentValue
      attr_reader :investments

      def initialize(cost:)
        @cost, @investments = cost, []
      end

      def append_investment(investment)
        investments << investment
      end

      def calculate(using_equivalency:)
        investments.each_with_index.inject(0) do |sum, (investment, index)|
          sum += investment.calculated_present_value(using_equivalency, index+1)
        end - @cost

      rescue UncalculableInvestmentValueError
        raise CashFlowCalculationError,
              'An error occurred on Net Present Value calculation due to cash flow inconsistencies.'
      end
    end
  end
end
