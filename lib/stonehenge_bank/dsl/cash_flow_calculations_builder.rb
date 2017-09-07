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
        validate_cash_flow_instance_presence!

        returns.each do |return_value|
          cash_flow.append_investment_return(
            Resources::Investment.new(future_value: Float(return_value))
          )
        end
      rescue ArgumentError
        raise Resources::CashFlowError,
              'An error occurred when trying to parse cash flow returns.'
      end

      def net_present_value
        validate_cash_flow_instance_presence!
        validate_equivalency_presence!

        cash_flow.net_present_value(
          Calculators::NetPresentValue.new, with_rate_equivalency: equivalency
        )
      end

      def simple_payback
        validate_cash_flow_instance_presence!
        cash_flow.payback_period(Calculators::Payback.simple)
      end

      def discounted_payback
        validate_cash_flow_instance_presence!
        validate_equivalency_presence!
        cash_flow.payback_period(Calculators::Payback.discounted(equivalency))
      end

      private

      def validate_cash_flow_instance_presence!
        unless cash_flow
          raise 'Cash flow calculation was not properly built: Cash flow instance is missing.'
        end
      end
    end
  end
end
