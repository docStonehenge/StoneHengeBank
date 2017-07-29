module StonehengeBank
  module Cli
    class CashFlowCalculationsBuilder
      include EquivalencyResolvable

      def initialize(options)
        @options = options
      end

      def an_investment(with_initial_cost:)
        @cash_flow = Resources::CashFlow.new(cost: with_initial_cost)
      end

      def has_returns_of(*returns)
        returns.each do |return_value|
          @cash_flow.append_investment_return(
            Resources::Investment.new(future_value: Float(return_value))
          )
        end
      rescue ArgumentError
        raise Resources::CashFlowError,
              'An error occurred when trying to parse cash flow returns.'
      end
    end
  end
end
