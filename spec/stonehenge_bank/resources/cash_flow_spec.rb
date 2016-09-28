module StonehengeBank
  module Resources
    describe CashFlow do
      let(:investment) { double(:investment) }

      subject { described_class.new(cost: 3_000) }

      it { is_expected.to have_attributes(cost: 3_000, investments: []) }

      describe '#append_investment_return investment' do
        it 'appends an investment into its collection' do
          subject.append_investment_return investment
          expect(subject.investments).to include investment
        end
      end

      describe '#net_present_value npv_calculator, with_rate_equivalency:' do
        let(:net_present_value_calculator) { double(:net_present_value_calculator) }
        let(:rate_equivalency)             { double(:rate_equivalency) }

        it 'delegates net present value calculation to calculator object using itself' do
          expect(
            net_present_value_calculator
          ).to receive(:calculate).with(subject, using_equivalency: rate_equivalency).and_return 3_500

          expect(
            subject.net_present_value(net_present_value_calculator, with_rate_equivalency: rate_equivalency)
          ).to eql 3_500
        end

        it 'raises CashFlowCalculationError due to calculation inconsistencies' do
          expect(
            net_present_value_calculator
          ).to receive(:calculate).with(
                 subject, using_equivalency: rate_equivalency
               ).and_raise CashFlowCalculationError, 'Foo'

          expect {
            subject.net_present_value(net_present_value_calculator, with_rate_equivalency: rate_equivalency)
          }.to raise_error(CashFlowCalculationError, 'Foo')
        end
      end

      describe '#payback_period payback_calculator' do
        let(:payback_calculator) { double(:payback_calculator) }

        it 'delegates calculation to payback calculator using itself' do
          expect(payback_calculator).to receive(:calculate).with(subject).and_return 3
          expect(subject.payback_period(payback_calculator)).to eql 3
        end

        it 'raises CashFlowCalculationError due to calculation inconsistencies' do
          expect(
            payback_calculator
          ).to receive(:calculate).with(subject).and_raise CashFlowCalculationError, 'Foo'

          expect {
            subject.payback_period(payback_calculator)
          }.to raise_error(CashFlowCalculationError, 'Foo')
        end
      end
    end
  end
end
