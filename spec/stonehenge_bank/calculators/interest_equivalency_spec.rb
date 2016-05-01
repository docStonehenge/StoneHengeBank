require 'stonehenge_bank/calculators/interest_equivalency'

module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      subject { described_class.new(double(:interest_rate)) }

      describe '#transformed_rate' do
        it 'raises error to subclasses implement it' do
          expect{
            subject.transformed_rate
          }.to raise_error(NotImplementedError, 'Subclasses must provide their values.')
        end
      end
    end
  end
end
