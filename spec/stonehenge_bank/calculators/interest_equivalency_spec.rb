module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      let(:interest_rate) { double(:interest_rate) }

      describe '.get_equivalency_for periodicity, rate' do
        it 'returns equivalency instance for proper periodicity' do
          expect(
            described_class.get_equivalency_for(:year, interest_rate)
          ).to be_an_instance_of YearInterestEquivalency

          expect(
            described_class.get_equivalency_for(:semester, interest_rate)
          ).to be_an_instance_of SemesterInterestEquivalency

          expect(
            described_class.get_equivalency_for(:trimester, interest_rate)
          ).to be_an_instance_of TrimesterInterestEquivalency

          expect(
            described_class.get_equivalency_for(:month, interest_rate)
          ).to be_an_instance_of MonthInterestEquivalency

          expect(
            described_class.get_equivalency_for(:day, interest_rate)
          ).to be_an_instance_of DayInterestEquivalency
        end

        it 'raises custom error for invalid periodicity' do
          expect {
            described_class.get_equivalency_for(:foo, interest_rate)
          }.to raise_error(
                 InvalidInterestEquivalencyError,
                 'An attempt was made to set equivalency with invalid value.'
               )
        end
      end

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
