module StonehengeBank
  module Formatters
    module FutureValueMessageFormatter
      def calculation_with_message(equivalency, period)
        @message.with_value(
          humanized_value_type(:present_value), @investment.present_value
        )

        @message.with_rate(interest_rate_percentage_for(equivalency.transformed_rate))
        @message.with_period(formatted_periodicity_with(equivalency), period)

        @message.returns_value(
            humanized_value_type(:future_value),
            @investment.calculated_future_value(equivalency, period)
          )
      end
    end
  end
end
