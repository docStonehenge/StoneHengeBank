module StonehengeBank
  module Calculators
    class InterestEquivalency
      def self.get_equivalency_for(periodicity, rate)
        Calculators.const_get(
          "#{periodicity.capitalize}InterestEquivalency"
        ).new(rate)
      rescue NameError
        raise(
          InvalidInterestEquivalencyError,
          'An attempt was made to set equivalency with invalid value.'
        )
      end

      def initialize(interest_rate)
        @interest_rate = interest_rate
      end

      def transformed_rate
        matches_rate_period? ? @interest_rate.value : calculate_rate
      end

      def equivalent_rate_power
        public_send("#{@interest_rate.period}_rate_power")
      end

      def matches_rate_period?
        raise NotImplementedError, 'Subclasses must provide their values.'
      end

      private

      def calculate_rate
        ((1 + @interest_rate.value) ** equivalent_rate_power - 1).round(5)
      end
    end
  end
end
