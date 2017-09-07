module StonehengeBank
  module DSL
    describe EquivalencyMissingError do
      it 'has default message on initialization' do
        expect(subject.message).to eql 'Interest rate equivalency is missing.'
      end
    end
  end
end
