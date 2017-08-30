module StonehengeBank
  module DSL
    describe EquivalencyMissingError do
      context 'as a subclass of ArgumentError' do
        it { is_expected.to respond_to :message }
      end

      it '#message' do
        expect(subject.message).to eql 'Interest rate equivalency is missing.'
      end
    end
  end
end
