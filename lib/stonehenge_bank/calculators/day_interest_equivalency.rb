module StonehengeBank
  module Calculators
    class DayInterestEquivalency < InterestEquivalency
      def equivalent_rate_power
        return 1.0/360 if @interest_rate.annually?
        return 1.0/180 if @interest_rate.semiannually?
        return 1.0/90 if @interest_rate.quarterly?
        return 1.0/30 if @interest_rate.monthly?
      end

      def matches_rate_period?
        @interest_rate.daily?
      end
    end
  end
end
