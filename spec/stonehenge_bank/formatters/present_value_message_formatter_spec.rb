module StonehengeBank
  module Formatters
    describe PresentValueMessageFormatter do
      let(:investment)  { double(:investment) }
      let(:equivalency) { Calculators::YearInterestEquivalency.new(double) }

      subject { described_class.new(investment) }

      specify { expect(subject.current_value_type).to eql :future_value }
      specify { expect(subject.value_to_reach_type).to eql :present_value }

      describe '#calculation_with_message equivalency, period' do
        it 'returns investment present value calculation inside an explanation message' do
          expect(investment).to receive(:future_value).and_return 1500.0
          allow(equivalency).to receive(:transformed_rate).and_return 0.1248
          expect(investment).to receive(
                                  :calculated_present_value
                                ).with(equivalency, 2).and_return 1000.0

          expect(
            subject.calculation_with_message(equivalency, 2)
          ).to eql "An investment with future value of $1500.0, an interest rate of 12.48, on a period of 2 year(s), has to have a present value of $1000.0."
        end
      end
    end
  end
end
