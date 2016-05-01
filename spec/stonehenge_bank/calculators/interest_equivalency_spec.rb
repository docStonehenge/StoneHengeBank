require 'stonehenge_bank/calculators/interest_equivalency'

module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      let(:interest_rate) { double(:interest_rate) }

      subject do
        described_class.new(interest_rate, for_period: 2)
      end

      specify { expect(subject).to have_attributes(period: 2) }

      describe '#transformed_rate' do
        it 'raises error since it is a superclass' do
          expect {
            subject.transformed_rate
          }.to raise_error(NotImplementedError, 'Subclasses must set #calculate_rate! with their own values and call here.')
        end
      end
    end
  end
end
