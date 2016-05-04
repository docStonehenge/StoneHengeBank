module StonehengeBank
  module Calculators
    class YearInterestEquivalency < InterestEquivalency
      def transformed_rate
        @interest_rate.annually? ?
          @interest_rate.value : calculate_rate
      end

      def equivalent_rate_power
        return 12 if @interest_rate.monthly?
        return 4 if @interest_rate.quarterly?
        return 2 if @interest_rate.semiannually?
        return 360 if @interest_rate.daily?
      end
    end
  end
end
