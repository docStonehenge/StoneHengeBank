module StonehengeBank
  module Cli
    module InterfaceDSL
      def self.simple_calculations(&block)
        SimpleCalculationsBuilder.new.instance_eval(&block)
      rescue => e
        e.message
      end
    end
  end
end
