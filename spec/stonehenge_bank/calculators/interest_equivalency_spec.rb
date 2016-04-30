require 'stonehenge_bank/calculators/interest_equivalency'

module StonehengeBank
  module Calculators
    describe InterestEquivalency do
      subject do
        described_class.new(interest_rate: '0.6% monthly', period: '2 years')
      end

      specify { expect(subject).to have_attributes(interest_rate: 0.006) }
      specify { expect(subject).to have_attributes(period: 2) }

      describe '#transformed_rate' do
        specify 'when rate is monthly and period in years' do
          expect(subject.transformed_rate).to eql(7.44)
        end

        specify 'when rate is monthly and period is in semesters' do
          subject = described_class.new(
            interest_rate: '0.6% monthly', period: '2 semesters'
          )

          puts subject.inspect
          expect(subject.transformed_rate).to eql(3.65)
        end

        specify 'when rate is monthly and period is in quarters' do
          subject = described_class.new(
            interest_rate: '0.6% monthly', period: '6 quarters'
          )

          expect(subject.transformed_rate).to eql(1.81)
        end
      end
    end
  end
end
