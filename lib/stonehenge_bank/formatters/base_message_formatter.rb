module StonehengeBank
  module Formatters
    module BaseMessageFormatter
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
