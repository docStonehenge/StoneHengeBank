module StonehengeBank
  module Resources
    class CashFlow
      attr_reader :cost, :investments

      def initialize(cost:)
        @cost, @investments = cost, []
      end

      def append_investment_return(investment)
        investments << investment
      end

      def calculated_net_present_value(npv_calculator, with_rate_equivalency:)
        npv_calculator.calculate(self, using_equivalency: with_rate_equivalency)
      end
    end
  end
end