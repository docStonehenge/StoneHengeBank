module StonehengeBank
  module Calculators
    class TrimesterInterestEquivalency < InterestEquivalency
      def matches_rate_period?
        @interest_rate.quarterly?
      end

      def annually_rate_power
        0.25
      end

      def semiannually_rate_power
        0.5
      end

      def monthly_rate_power
        3
      end

      def daily_rate_power
        90
      end
    end
  end
end
