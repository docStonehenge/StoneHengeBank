module StonehengeBank
  module Resources
    describe Investment do
      let(:interest_rate)        { double(:interest_rate) }
      let(:interest_equivalency) { double(:calculator) }

      context 'a newly created investment' do
        subject { described_class.new(present_value: 100.0) }

        it { is_expected.to have_attributes(present_value: 100.0, future_value: nil) }
      end

      context 'can be created with a future value instead' do
        subject { described_class.new(future_value: 100.0) }

        it { is_expected.to have_attributes(present_value: nil, future_value: 100.0) }
      end

      subject { described_class.new(present_value: 100.0) }

      before do
        allow(
          Calculators::YearInterestEquivalency
        ).to receive(:new).with(interest_rate).and_return(interest_equivalency)
      end

      describe '#calculated_future_value equivalency, period' do
        it 'returns the calculated future value based on the period asked' do
          allow(interest_equivalency).to receive(:transformed_rate).
                                          and_return(0.006)

          expect(
            subject.calculated_future_value(interest_equivalency, 2)
          ).to eql(101.20)

          expect(subject.future_value).to eql 101.20
        end

        it 'raises error if present value is not set' do
          subject.present_value = nil

          expect {
            subject.calculated_future_value(interest_equivalency, 2)
          }.to raise_error(
                 ::UncalculableInvestmentValueError,
                 'Cannot calculate future value without a present value.'
               )
        end
      end

      describe '#calculated_present_value equivalency, period' do
        it 'returns the calculated present value based on the period asked' do
          subject.future_value  = 150.0
          subject.present_value = nil

          allow(interest_equivalency).to receive(:transformed_rate).
                                          and_return(0.006)

          expect(
            subject.calculated_present_value(interest_equivalency, 2)
          ).to eql(148.22)

          expect(subject.present_value).to eql 148.22
        end

        it 'raises error if future value is not set' do
          subject.future_value = nil

          expect {
            subject.calculated_present_value(interest_equivalency, 2)
          }.to raise_error(
                 ::UncalculableInvestmentValueError,
                 'Cannot calculate present value without a future value.'
               )
        end
      end

      describe '#calculated_investment_period equivalency' do
        it 'returns the period in which an investment takes place to a determined value and rate' do
          subject.future_value = 1450.0

          allow(interest_equivalency).to receive(:transformed_rate).
                                          and_return(0.1248)

          expect(
            subject.calculated_investment_period(interest_equivalency)
          ).to eql 23
        end

        it 'returns an error if present value is not set' do
          subject.present_value = nil
          subject.future_value  = 1450.0

          expect {
            subject.calculated_investment_period(interest_equivalency)
          }.to raise_error('Cannot calculate period with null values.')
        end

        it 'returns an error if future value is not set' do
          expect {
            subject.calculated_investment_period(interest_equivalency)
          }.to raise_error('Cannot calculate period with null values.')
        end
      end

      describe '#calculated_investment_rate period' do
        it 'returns the interest rate for the investment at hand' do
          subject.future_value = 1450.0

          expect(
            subject.calculated_investment_rate(36)
          ).to eql 0.07711
        end

        it 'returns an error if present value is nil' do
          subject.present_value = nil
          subject.future_value  = 1450.0

          expect {
            subject.calculated_investment_rate(36)
          }.to raise_error(::UncalculableInvestmentValueError, 'Cannot calculate interest rate with null values.')
        end

        it 'returns an error if future value is nil' do
          expect {
            subject.calculated_investment_rate(36)
          }.to raise_error(::UncalculableInvestmentValueError, 'Cannot calculate interest rate with null values.')
        end
      end

      describe '#calculated_regular_parcel equivalency, period' do
        it 'returns the amount for the regular parcel to retrieve a future value' do
          subject.present_value = 100_000
          subject.future_value  = 1_000_000.0

          allow(interest_equivalency).to receive(:transformed_rate).and_return 0.13

          expect(
            subject.calculated_regular_parcel(interest_equivalency, 3)
          ).to eql 251_169.77
        end

        it 'raises error if future_value is not set' do
          allow(interest_equivalency).to receive(:transformed_rate).and_return 0.1248

          expect {
            subject.calculated_regular_parcel(interest_equivalency, 3)
          }.to raise_error(
                 ::UncalculableInvestmentValueError,
                 'Cannot calculate regular parcel with null values.'
               )
        end

        it 'raises error if present_value is not set' do
          subject.present_value = nil
          subject.future_value  = 1500.0

          allow(interest_equivalency).to receive(:transformed_rate).and_return 0.1248

          expect {
            subject.calculated_regular_parcel(interest_equivalency, 3)
          }.to raise_error(
                 ::UncalculableInvestmentValueError,
                 'Cannot calculate regular parcel with null values.'
               )
        end
      end
    end
  end
end
