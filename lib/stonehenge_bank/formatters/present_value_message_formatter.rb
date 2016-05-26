module StonehengeBank
  module Formatters
    class PresentValueMessageFormatter
      include BaseMessageFormatter

      def initialize(investment)
        @investment = investment
      end

      def calculation_with_message(equivalency, period)
        "An investment with future value of $#{@investment.future_value}, an interest rate of #{interest_rate_percentage_for(equivalency)}%, on a period of #{period} #{formatted_periodicity_with(equivalency)}(s), has to have a present value of $#{@investment.calculated_present_value(equivalency, period)}."
      end
    end
  end
end
