module StonehengeBank
  module Calculators
    class YearInterestEquivalency < InterestEquivalency
      def matches_rate_period?
        @interest_rate.annually?
      end

      def monthly_rate_power
        12
      end

      def quarterly_rate_power
        4
      end

      def semiannually_rate_power
        2
      end

      def daily_rate_power
        360
      end
    end
  end
end
