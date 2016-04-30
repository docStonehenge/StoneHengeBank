module StonehengeBank
  module Calculators
    class InterestEquivalency
      def initialize(interest_rate:, period:)
        @interest_rate, @period = interest_rate, period
      end

      def interest_rate
        @interest_rate.chomp('%').to_f / 100.0
      end

      def period
        @period.chop.to_i
      end

      def transformed_rate
        if monthly_to_annually?
          set_rate_based_on(12)
        elsif monthly_to_half_year?
          set_rate_based_on(6)
        elsif monthly_to_quarterly?
          set_rate_based_on(3)
        end
      end

      private

      def monthly_to_annually?
        @interest_rate =~ /(month|a\.m\.)/ && @period =~ /year/
      end

      def monthly_to_half_year?
        @interest_rate =~ /(month|a\.m\.)/ && @period =~ /semester/
      end

      def monthly_to_quarterly?
        @interest_rate =~ /(month|a\.m\.)/ && @period =~ /quarter/
      end

      def set_rate_based_on(quantity)
        (((1 + interest_rate)**quantity - 1) * 100.0).round(2)
      end
    end
  end
end
