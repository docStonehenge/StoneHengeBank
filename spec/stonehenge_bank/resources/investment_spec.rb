module StonehengeBank
  module Resources
    describe Investment do
      let(:interest_rate) { double(:interest_rate) }
      let(:interest_equivalency) { double(:calculator) }

      context 'a newly created investment' do
        subject { described_class.new(interest_rate, present_value: 100.0) }

        specify { expect(subject).to have_attributes(present_value: 100.0) }
      end

      context 'can be created with a future value instead' do
        subject { described_class.new(interest_rate, future_value: 100.0) }

        specify { expect(subject).to have_attributes(future_value: 100.0) }
      end

      subject { described_class.new(interest_rate, present_value: 100.0) }

      describe '#calculated_future_value period, quantity' do
        it 'returns the calculated future value based on the period asked' do
          expect(
            Calculators::YearInterestEquivalency
          ).to receive(:new).with(interest_rate).and_return(interest_equivalency)

          expect(interest_equivalency).to receive(:transformed_rate).and_return(0.006)

          expect(subject.calculated_future_value(:year, 2)).to eql(101.20)
        end
      end

      describe '#calculated_present_value period, quantity' do
        let(:investment) { Investment.new(interest_rate, future_value: 150.0) }

        it 'returns the calculated present value based on the period asked' do
          expect(
            Calculators::YearInterestEquivalency
          ).to receive(:new).with(interest_rate).and_return(interest_equivalency)

          expect(interest_equivalency).to receive(:transformed_rate).and_return(0.006)

          expect(investment.calculated_present_value(:year, 2)).to eql(148.22)
        end
      end
    end
  end
end
