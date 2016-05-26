module StonehengeBank
  module Formatters
    class FutureValueMessageFormatter
      def initialize(investment)
        @investment = investment
      end

      def calculation_with_message(equivalency, period)
        "An investment with present value of $#{@investment.present_value}, an interest rate of #{interest_rate_percentage_for(equivalency)}% on a period of #{period} #{formatted_periodicity_with(equivalency)}(s), returns a future value of $#{@investment.calculated_future_value(equivalency, period)}."
      end

      private

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
