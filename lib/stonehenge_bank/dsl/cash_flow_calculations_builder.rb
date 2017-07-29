module StonehengeBank
  module DSL
    class CashFlowCalculationsBuilder
      include EquivalencyResolvable

      attr_reader :cash_flow

      def initialize(options)
        @options = options
      end

      def an_investment(with_initial_cost:)
        @cash_flow = Resources::CashFlow.new(cost: Float(with_initial_cost))
      rescue ArgumentError
        raise Resources::CashFlowError,
              'An error occurred when trying to parse cash flow cost.'
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

      def net_present_value
        raise ArgumentError, 'Interest rate equivalency is missing' unless equivalency

        cash_flow.net_present_value(
          Calculators::NetPresentValue.new, with_rate_equivalency: equivalency
        )
      end
    end
  end
end
