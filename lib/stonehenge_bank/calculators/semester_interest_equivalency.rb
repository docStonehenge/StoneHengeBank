module StonehengeBank
  module Calculators
    class SemesterInterestEquivalency < InterestEquivalency
      def matches_rate_period?
        @interest_rate.semiannually?
      end

      def annually_rate_power
        0.5
      end

      def quarterly_rate_power
        2
      end

      def monthly_rate_power
        6
      end

      def daily_rate_power
        180
      end
    end
  end
end
