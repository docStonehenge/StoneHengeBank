require 'stonehenge_bank/calculators/interest_equivalency'

module StonehengeBank
  module Calculators
    class AnnualInterestEquivalency < InterestEquivalency
      def transformed_rate
        @interest_rate.annually? ?
          @interest_rate.value : calculate_rate!(equivalent_rate_power)
      end

      private

      def equivalent_rate_power
        if @interest_rate.monthly?
          12
        elsif @interest_rate.semiannually?
          2
        elsif @interest_rate.quarterly?
          4
        end
      end
    end
  end
end
