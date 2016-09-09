module StonehengeBank
  module Messages
    describe InvestmentMessage do
      describe '#with_rate_of rate' do
        it 'sets its text with interest rate information' do
          expect(
            subject.with_rate(12.48)
          ).to eql 'An investment with an interest rate of 12.48%,'
        end
      end

      describe '#with_period periodicity, value' do
        it 'sets its text with periodicity information' do
          expect(
            subject.with_period('year', 2)
          ).to eql 'An investment on a period of 2 year(s),'
        end
      end

      describe '#with_value value_type, value' do
        it 'sets its text with value information' do
          expect(
            subject.with_value('future value', 1500.0)
          ).to eql 'An investment with a future value of $1500.0,'
        end
      end

      describe '#returns_value value_type, value' do
        it 'sets a text of return value information' do
          expect(
            subject.returns_value('future value', 1500.0)
          ).to eql 'An investment returns a future value of $1500.0.'
        end
      end

      describe '#has_value value_type, value' do
        it 'sets a text of value presence information' do
          expect(
            subject.has_value('present value', 1000.0)
          ).to eql 'An investment has present value of $1000.0.'
        end
      end
    end
  end
end
