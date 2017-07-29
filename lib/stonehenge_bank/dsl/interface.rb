module StonehengeBank
  module DSL
    module Interface
      def self.simple_calculations(with_options: {}, &block)
        SimpleCalculationsBuilder.new(with_options).instance_eval(&block)
      rescue => e
        e.message
      end
    end
  end
end
