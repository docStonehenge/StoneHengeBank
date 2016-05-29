module StonehengeBank
  module Formatters
    module InvestmentPeriodMessageFormatter
      def calculation_with_message(equivalency)
        @message.has_value(
          humanized_value_type(:present_value), @investment.present_value, separator: ','
        )

        @message.has_value(
          humanized_value_type(:future_value), @investment.future_value, separator: ','
        )

        @message.with_rate(interest_rate_percentage_for(equivalency.transformed_rate))

        @message.with_period(
          formatted_periodicity_with(equivalency), @investment.calculated_investment_period(equivalency), separator: '.'
        )
      end
    end
  end
end
