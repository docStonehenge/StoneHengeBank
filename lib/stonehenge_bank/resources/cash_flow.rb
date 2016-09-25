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
    end
  end
end
