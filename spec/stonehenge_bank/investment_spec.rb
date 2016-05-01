require 'stonehenge_bank/investment'

module StonehengeBank
  describe Investment do
    context 'a newly created investment' do
      subject { described_class.new(present_value: 100.0) }

      specify { expect(subject).to have_attributes(present_value: 100.0) }
    end

    context 'can be created with a future value instead' do
      subject { described_class.new(future_value: 100.0) }

      specify { expect(subject).to have_attributes(future_value: 100.0) }
    end
  end
end
