module StonehengeBank
  module DSL
    module Interface
      class << self
        def simple_calculations(with_options: { raise_errors: true }, &block)
          calculation_interface_for(
            SimpleCalculationsBuilder, with_options, &block
          )
        end

        def cash_flow_calculations(with_options: { raise_errors: true }, &block)
          calculation_interface_for(
            CashFlowCalculationsBuilder, with_options, &block
          )
        end

        private

        def calculation_interface_for(builder_klass, with_options, &block)
          builder_klass.new(with_options).instance_eval(&block)
        rescue => e
          raise e if with_options.dig(:raise_errors)
          e.message
        end
      end
    end
  end
end
