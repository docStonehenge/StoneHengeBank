module StonehengeBank
  module Calculators
    class SemesterInterestEquivalency < InterestEquivalency
      def equivalent_rate_power
        return 0.5 if @interest_rate.annually?
        return 2 if @interest_rate.quarterly?
        return 6 if @interest_rate.monthly?
        return 180 if @interest_rate.daily?
      end

      def matches_rate_period?
        @interest_rate.semiannually?
      end
    end
  end
end
