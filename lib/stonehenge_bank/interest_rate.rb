module StonehengeBank
  class InterestRate
    attr_reader :value, :period

    def initialize(value, period)
      @value, @period = value, period
    end

    def method_missing(method_name)
      if matches_real_period? method_name
        self.class.class_eval do
          define_method method_name do
            instance_variable_get(:@period) =~ /#{method_name.to_s.chomp('?')}/
          end
        end
      else
        super
      end
    end

    private

    def matches_real_period?(period)
      period =~ /annual|daily|month|semiannual|quarter/
    end
  end
end
