module StonehengeBank
  module Calculators
    class DayInterestEquivalency < InterestEquivalency
      def matches_rate_period?
        @interest_rate.daily?
      end

      def annually_rate_power
        1.0 / 360
      end

      def semiannually_rate_power
        1.0 / 180
      end

      def quarterly_rate_power
        1.0 / 90
      end

      def monthly_rate_power
        1.0 / 30
      end
    end
  end
end
