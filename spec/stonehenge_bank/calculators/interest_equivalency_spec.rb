module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      subject { described_class.new(double(:interest_rate)) }

      describe '#equivalent_rate_power' do
        it 'raises error for subclasses to implement it' do
          expect {
            subject.equivalent_rate_power
          }.to raise_error(NotImplementedError, 'Subclasses must provide their values.')
        end
      end

      describe '#matches_rate_period?' do
        it 'raises error for subclasses to implement it' do
          expect {
            subject.matches_rate_period?
          }.to raise_error(NotImplementedError, 'Subclasses must provide their values.')
        end
      end
    end
  end
end
