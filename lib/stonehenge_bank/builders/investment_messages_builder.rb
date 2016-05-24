module StonehengeBank
  module Builders
    class InvestmentMessagesBuilder
      CALCULATED_VALUE_MESSAGE = "An investment with %{current_value_type} \
value of $%{current_value}, an interest rate of %{rate} and a period of \
%{period_quantity} %{period}(s) returns a %{value_to_reach_type} \
value of $%{value_to_reach}."

      ERROR_MESSAGE = "Cannot elaborate a message because of an error on \
the investment calculation: %{error}. Please, check the values needed to \
be able to call the calculation again."

      def initialize(investment)
        @investment = investment
      end

      def calculated_future_value_message(equivalency, period)
        CALCULATED_VALUE_MESSAGE % {
          current_value_type: :present,
          current_value: @investment.present_value,
          rate: equivalency_rounded_rate(equivalency.transformed_rate),
          period_quantity: period,
          period: equivalency_period(equivalency.class),
          value_to_reach_type: :future,
          value_to_reach: @investment.calculated_future_value(equivalency, period)
        }
      rescue StonehengeBank::Resources::Investment::UncalculableInvestmentValueError => e
        ERROR_MESSAGE % { error: e.to_s }
      end

      private

      def equivalency_rounded_rate(rate)
        (rate * 100).round(2)
      end

      def equivalency_period(equivalency_class)
        equivalency_class.to_s.downcase.match(
          /year|semester|trimester|month|day/
        )[0]
      end
    end
  end
end
