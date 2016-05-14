module StonehengeBank
  module Calculators
    class MonthInterestEquivalency < InterestEquivalency
      def equivalent_rate_power
        return (1.0/12) if @interest_rate.annually?
        return (1.0/6) if @interest_rate.semiannually?
        return (1.0/3) if @interest_rate.quarterly?
        return 30 if @interest_rate.daily?
      end

      def matches_rate_period?
        @interest_rate.monthly?
      end
    end
  end
end
