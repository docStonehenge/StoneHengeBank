module StonehengeBank
  module Calculators
    class MonthInterestEquivalency < InterestEquivalency
      def transformed_rate
        if @interest_rate.monthly?
          @interest_rate.value
        else
          calculate_rate
        end
      end

      def equivalent_rate_power
        return (1.0/12) if @interest_rate.annually?
        return (1.0/6) if @interest_rate.semiannually?
        return (1.0/3) if @interest_rate.quarterly?
        return 30 if @interest_rate.daily?
      end
    end
  end
end
