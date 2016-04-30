module StonehengeBank
  class Investment
    attr_reader :present_value, :future_value

    def initialize(present_value: nil, future_value: nil)
      @present_value, @future_value = present_value, future_value
    end
  end
end
