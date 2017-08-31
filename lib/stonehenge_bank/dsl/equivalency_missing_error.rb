module StonehengeBank
  module DSL
    class EquivalencyMissingError < ArgumentError
      def initialize(_message = 'Interest rate equivalency is missing.')
        super
      end
    end
  end
end
