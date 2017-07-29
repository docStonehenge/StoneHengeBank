module StonehengeBank
  module DSL
    module Interface
      def self.simple_calculations(with_options: { raise_errors: true }, &block)
        SimpleCalculationsBuilder.new(with_options).instance_eval(&block)
      rescue => e
        raise e if with_options.dig(:raise_errors)
        e.message
      end
    end
  end
end
