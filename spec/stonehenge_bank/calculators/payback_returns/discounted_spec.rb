module StonehengeBank
  module Calculators
    module PaybackReturns
      describe Discounted do
        let(:investment) { double(:investment, future_value: 1000.0) }
        let(:rate_equivalency) { double(:rate_equivalency) }

        subject { described_class.new(rate_equivalency) }

        describe '#return_value_from investment, period' do
          it "return investment's calculated present_value" do
            expect(investment).to receive(
                                    :calculated_present_value
                                  ).with(rate_equivalency, 1).and_return 800.0

            expect(subject.return_value_from(investment, 1)).to eql 800.0
          end
        end
      end
    end
  end
end
