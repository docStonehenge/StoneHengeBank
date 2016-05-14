module StonehengeBank
  module Calculators
    class TrimesterInterestEquivalency < InterestEquivalency
      def equivalent_rate_power
        return 0.25 if @interest_rate.annually?
        return 0.5 if @interest_rate.semiannually?
        return 3 if @interest_rate.monthly?
        return 90 if @interest_rate.daily?
      end

      def matches_rate_period?
        @interest_rate.quarterly?
      end
    end
  end
end
