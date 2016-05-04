module StonehengeBank
  module Calculators
    class SemesterInterestEquivalency < InterestEquivalency
      def transformed_rate
        if @interest_rate.semiannually?
          @interest_rate.value
        else
          calculate_rate
        end
      end

      def equivalent_rate_power
        return 0.5 if @interest_rate.annually?
        return 2 if @interest_rate.quarterly?
        return 6 if @interest_rate.monthly?
        return 180 if @interest_rate.daily?
      end
    end
  end
end
