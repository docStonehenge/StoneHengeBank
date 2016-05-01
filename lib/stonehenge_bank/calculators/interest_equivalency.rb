module StonehengeBank
  module Calculators
    class InterestEquivalency
      def initialize(interest_rate)
        @interest_rate = interest_rate
      end

      def transformed_rate
        raise NotImplementedError, 'Subclasses must provide their values.'
      end

      private

      def calculate_rate(rate_power)
        (((1 + @interest_rate.value)**rate_power - 1) * 100.0).round(2)
      end
    end
  end
end
