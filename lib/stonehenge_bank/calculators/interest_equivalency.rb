module StonehengeBank
  module Calculators
    class InterestEquivalency
      def initialize(interest_rate)
        @interest_rate = interest_rate
      end

      def transformed_rate
        raise NotImplementedError, 'Subclasses must provide their values.'
      end

      def calculate_rate
        ((1 + @interest_rate.value)**equivalent_rate_power - 1).round(5)
      end

      def equivalent_rate_power
        raise NotImplementedError, 'Subclasses must provide their values.'
      end
    end
  end
end
