module StonehengeBank
  module Formatters
    module BaseMessageFormatter
      def calculation_with_message(equivalency, period)
        yield "An investment with #{humanized_value_type(current_value_type)} of \
$#{@investment.public_send(current_value_type)}, an interest rate of \
#{interest_rate_percentage_for(equivalency)}, on a period of #{period} \
#{formatted_periodicity_with(equivalency)}(s), %{message_verb} a \
#{humanized_value_type(value_to_reach_type)} of \
$#{investment_calculation_with(equivalency, period)}."
      end

      private

      def investment_calculation_with(equivalency, period)
        @investment.public_send(
          "calculated_#{value_to_reach_type}", equivalency, period
        )
      end

      def humanized_value_type(type)
        type.to_s.tr('_', ' ')
      end

      def interest_rate_percentage_for(equivalency)
        (equivalency.transformed_rate * 100).round(2)
      end

      def formatted_periodicity_with(equivalency)
        equivalency.class.to_s.downcase.match(
          /year|semester|trimester|month|day/
        )[0]
      end
    end
  end
end
