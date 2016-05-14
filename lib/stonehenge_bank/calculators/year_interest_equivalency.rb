module StonehengeBank
  module Calculators
    class YearInterestEquivalency < InterestEquivalency
      def equivalent_rate_power
        return 12 if @interest_rate.monthly?
        return 4 if @interest_rate.quarterly?
        return 2 if @interest_rate.semiannually?
        return 360 if @interest_rate.daily?
      end

      def matches_rate_period?
        @interest_rate.annually?
      end
    end
  end
end
