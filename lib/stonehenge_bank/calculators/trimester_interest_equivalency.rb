module StonehengeBank
  module Calculators
    class TrimesterInterestEquivalency < InterestEquivalency
      def transformed_rate
        if @interest_rate.quarterly?
          @interest_rate.value
        else
          calculate_rate
        end
      end

      def equivalent_rate_power
        return 0.25 if @interest_rate.annually?
        return 0.5 if @interest_rate.semiannually?
        return 3 if @interest_rate.monthly?
      end
    end
  end
end
