module StonehengeBank
  class Investment
    attr_writer :interest_rate
    attr_reader :present_value, :future_value

    def initialize(present_value: nil, future_value: nil, interest_rate:, period:)
      @present_value, @interest_rate = present_value, interest_rate
      @future_value, @period = future_value, period
    end

    def interest_rate
      @interest_rate.chomp('%').to_f / 100.0
    end

    def period
      @period.chop.to_i
    end

    def monthly?
      @interest_rate.end_with? 'monthly'
    end

    def annually?
      @interest_rate.end_with? 'annually', 'yearly'
    end
  end
end
