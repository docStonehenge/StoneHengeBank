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
          (((1 + interest_rate)**12 - 1) * 100.0).round(2)
        elsif monthly_to_half_year?
          (((1 + interest_rate)**6 - 1) * 100.0).round(2)
        end
      end

      private

      def monthly_to_annually?
        @interest_rate =~ /(month|a\.m\.)/ && @period =~ /year/
      end

      def monthly_to_half_year?
        @interest_rate =~ /(month|a\.m\.)/ && @period =~ /semester/
      end
    end
  end
end
