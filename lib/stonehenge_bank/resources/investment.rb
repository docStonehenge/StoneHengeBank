module StonehengeBank
  module Resources
    class Investment
      attr_reader :present_value, :future_value

      def initialize(present_value: nil, future_value: nil)
        @present_value = present_value
        @future_value  = future_value
      end

      def calculated_future_value(equivalency, quantity)
        (@present_value * ((1 + equivalency.transformed_rate)**quantity)).round(2)
      end

      def calculated_present_value(equivalency, quantity)
        (@future_value / ((1 + equivalency.transformed_rate)**quantity)).round(2)
      end
    end
  end
end
