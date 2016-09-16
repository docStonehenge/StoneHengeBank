module StonehengeBank
  module Resources
    describe NetPresentValue do
      let(:investment) { double(:investment) }

      subject { described_class.new(cost: 3_000) }

      it { is_expected.to have_attributes(investments: []) }

      describe '#append_investment investment' do
        it 'appends an investment to hold its future value as a cash flow' do
          subject.append_investment investment
          expect(subject.investments).to include investment
        end
      end

      describe '#calculate using_equivalency:' do
        let(:investment_2)              { double(:investment) }
        let(:investment_3)              { double(:investment) }
        let(:year_interest_equivalency) { double(:year_interest_equivalency) }

        it 'calculates the net present value of a project with determined cash flows' do
          expect(subject).to receive(:investments).and_return [investment, investment_2, investment_3]
          expect(investment).to receive(
                                  :calculated_present_value
                                ).with(year_interest_equivalency, 1).and_return 900.0

          expect(investment_2).to receive(
                                    :calculated_present_value
                                  ).with(year_interest_equivalency, 2).and_return 1100.0

          expect(investment_3).to receive(
                                    :calculated_present_value
                                  ).with(year_interest_equivalency, 3).and_return 1200.0

          expect(
            subject.calculate(using_equivalency: year_interest_equivalency)
          ).to eql 200.0
        end
      end
    end
  end
end
