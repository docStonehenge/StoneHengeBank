module StonehengeBank
  module Formatters
    describe BaseMessageFormatter do
      subject { described_class.new(double) }

      describe '#for_type formatter_type' do
        it 'becomes a extend version of the formatter type chosen' do
          subject.for_type(:future_value)

          expect(subject).to be_a FutureValueMessageFormatter
        end

        it 'raises Formatters::FormatterNotFoundError if formatter does not exist' do
          expect {
            subject.for_type(:foo)
          }.to raise_error Formatters::FormatterNotFoundError,
                           'Foo message formatter does not exist.'
        end
      end
    end
  end
end
