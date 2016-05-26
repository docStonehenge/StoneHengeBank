module StonehengeBank
  module Calculators
    class MonthInterestEquivalency < InterestEquivalency
      def matches_rate_period?
        @interest_rate.monthly?
      end

      def anually_rate_power
        1.0 / 12
      end

      def semiannually_rate_power
        1.0 / 6
      end

      def quarterly_rate_power
        1.0 / 3
      end

      def daily_rate_power
        30
      end
    end
  end
end
