module StonehengeBank
  module DSL
    class EquivalencyMissingError < ArgumentError
      def message
        'Interest rate equivalency is missing.'
      end
    end
  end
end
