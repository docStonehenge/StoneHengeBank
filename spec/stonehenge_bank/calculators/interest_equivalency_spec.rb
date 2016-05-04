module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      let(:interest_rate) { double(:interest_rate, value: 0.15) }

      subject { described_class.new(interest_rate) }

      describe '#transformed_rate' do
        it 'raises error for subclasses to implement it' do
          expect{
            subject.transformed_rate
          }.to raise_error(NotImplementedError, 'Subclasses must provide their values.')
        end
      end

      describe '#equivalent_rate_power' do
        it 'raises error for subclasses to implement it' do
          expect {
            subject.equivalent_rate_power
          }.to raise_error(NotImplementedError, 'Subclasses must provide their values.')
        end
      end
    end
  end
end
