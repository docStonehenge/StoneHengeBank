module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        it 'calls matching period method' do
          allow(interest_rate).to receive(:period).and_return('monthly')
          expect(subject).to receive(:monthly_rate_power).and_return 12

          expect(subject.equivalent_rate_power).to eql 12
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
