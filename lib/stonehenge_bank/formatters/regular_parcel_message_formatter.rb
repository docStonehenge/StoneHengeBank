module StonehengeBank
  module Formatters
    module RegularParcelMessageFormatter
      def calculation_with_message(equivalency, period)
        @message.with_value(humanized_value_type(:present_value), @investment.present_value)

        @message.has_value(
          humanized_value_type(:future_value), @investment.future_value, separator: ','
        )

        @message.with_rate(interest_rate_percentage_for(equivalency.transformed_rate))
        @message.with_period(formatted_periodicity_with(equivalency), period)

        @message.with_value(
          humanized_value_type(:regular_parcel), @investment.calculated_regular_parcel(equivalency, period), separator: '.'
        )
      end
    end
  end
end
