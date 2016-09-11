module StonehengeBank
  module Resources
    class NetPresentValue
      attr_reader :investments

      def initialize(cost:)
        @cost, @investments = cost, []
      end

      def append_cash_flow(cash_flow)
        investments << Investment.new(future_value: cash_flow)
      end

      def calculate(using_equivalency:)
        investments.each_with_index.inject(0) do |sum, (investment, index)|
          sum += investment.calculated_present_value(using_equivalency, index+1)
        end - @cost
      end
    end
  end
end
