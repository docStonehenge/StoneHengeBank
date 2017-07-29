module StonehengeBank
  module Calculators
    describe Payback do
      let(:cash_flow)      { double(:cash_flow, cost: 3_000) }
      let(:investment_1)   { double(:investment, future_value: 1_200) }
      let(:investment_2)   { double(:investment, future_value: 1_500) }
      let(:investment_3)   { double(:investment, future_value: 1_800) }
      let(:payback_return) { double(:payback_return) }

      subject { described_class.new(payback_return) }

      before do
        expect(cash_flow).to receive(:investments).and_return(
                               [investment_1, investment_2, investment_3]
                             )
      end

      describe '#calculate cash_flow' do
        it 'returns the period where cash flow difference becomes zero' do
          expect(payback_return).to receive(:return_value_from).with(investment_1, 1).and_return 1_200
          expect(payback_return).to receive(:return_value_from).with(investment_2, 2).and_return 1_500
          expect(payback_return).to receive(:return_value_from).with(investment_3, 3).and_return 1_800
          expect(subject.calculate(cash_flow)).to eql 3
        end

        it 'returns nothing if the cash_flow difference never becomes greater than or equal to zero' do
          allow(investment_1).to receive(:future_value).and_return 0
          allow(investment_2).to receive(:future_value).and_return 200.0
          expect(payback_return).to receive(:return_value_from).with(investment_1, 1).and_return 0
          expect(payback_return).to receive(:return_value_from).with(investment_2, 2).and_return 200.0
          expect(payback_return).to receive(:return_value_from).with(investment_3, 3).and_return 1_800
          expect(subject.calculate(cash_flow)).to be_nil
        end

        it "raises CashFlowError if any cash_flow return doesn't have a future value" do
          allow(investment_1).to receive(:future_value).and_return nil

          expect {
            subject.calculate(cash_flow)
          }.to raise_error Resources::CashFlowError,
                           'An error occurred on Payback calculation due to cash flow inconsistencies.'
        end
      end
    end
  end
end
