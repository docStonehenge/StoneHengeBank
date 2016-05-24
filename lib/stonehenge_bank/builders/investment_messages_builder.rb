module StonehengeBank
  module Builders
    class InvestmentMessagesBuilder
      InvestmentMessagesOptions = OpenStruct.new(
        calculated_value_message: "An investment with %{current_value_type} \
value of $%{current_value}, an interest rate of %{rate} and a period of \
%{period_quantity} %{period}(s) %{verb} a %{value_to_reach_type} \
value of $%{value_to_reach}.",
        error_message: "Cannot elaborate a message because of an error on \
the investment calculation: %{error}. Please, check the values needed to \
be able to call the calculation again."
      )

      def initialize(investment)
        @investment = investment
      end

      def calculated_future_value_with_message(equivalency, period)
        InvestmentMessagesOptions.calculated_value_message % {
          current_value_type: :present,
          current_value: @investment.present_value,
          rate: equivalency_rounded_rate(equivalency.transformed_rate),
          period_quantity: period,
          period: equivalency_period(equivalency.class),
          verb: 'returns',
          value_to_reach_type: :future,
          value_to_reach: @investment.calculated_future_value(equivalency, period)
        }
      rescue StonehengeBank::Resources::Investment::UncalculableInvestmentValueError => e
        InvestmentMessagesOptions.error_message % { error: e.to_s }
      end

      def calculated_present_value_with_message(equivalency, period)
        InvestmentMessagesOptions.calculated_value_message % {
          current_value_type: :future,
          current_value: @investment.future_value,
          rate: equivalency_rounded_rate(equivalency.transformed_rate),
          period_quantity: period,
          period: equivalency_period(equivalency.class),
          verb: 'has to have',
          value_to_reach_type: :present,
          value_to_reach: @investment.calculated_present_value(equivalency, period)
        }
      rescue StonehengeBank::Resources::Investment::UncalculableInvestmentValueError => e
        InvestmentMessagesOptions.error_message % { error: e.to_s }
      end

      def calculated_investment_rate_with_message(period_kind, quantity)
        InvestmentMessagesOptions.calculated_value_message % {
          current_value_type: :present,
          current_value: @investment.present_value,
          rate: equivalency_rounded_rate(@investment.calculated_investment_rate(period_kind, quantity)),
          period_quantity: quantity,
          period: period_kind,
          verb: 'returns',
          value_to_reach_type: :future,
          value_to_reach: @investment.future_value
        }
      rescue StonehengeBank::Resources::Investment::UncalculableInvestmentValueError => e
        InvestmentMessagesOptions.error_message % { error: e.to_s }
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
