module StonehengeBank
  module Formatters
    module InvestmentRateMessageFormatter
      def calculation_with_message(period_amount)
        @message.has_value(
          humanized_value_type(:present_value), @investment.present_value, separator: ','
        )

        @message.has_value(
          humanized_value_type(:future_value), @investment.future_value, separator: ','
        )

        @message.with_period(:month, period_amount)

        @message.with_rate(
          interest_rate_percentage_for(
            @investment.calculated_investment_rate(period_amount)
          ), separator: '.'
        )
      end
    end
  end
end
