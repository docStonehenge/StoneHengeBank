module StonehengeBank
  module Calculators
    module PaybackReturns
      describe Simple do
        let(:investment) { double(:investment, future_value: 100.0) }

        describe '#return_value_from investment, _period' do
          it 'returns investment future value' do
            expect(subject.return_value_from(investment, 1)).to eql 100.0
          end
        end
      end
    end
  end
end
