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

    # describe '#monthly?' do
    #   subject do
    #     described_class.new(
    #       present_value: 100.0, interest_rate: '6% monthly', period: '1 year'
    #     )
    #   end

    #   it "is true if interest rate is set with 'monthly'" do
    #     expect(subject.monthly?).to be_truthy
    #   end

    #   it 'is false if interest rate is set with something else' do
    #     subject.interest_rate = '6% annually'
    #     expect(subject.monthly?).to be_falsey
    #   end
    # end

    # describe '#annually?' do
    #   subject do
    #     described_class.new(
    #       present_value: 100.0, interest_rate: '6% annually', period: '1 year'
    #     )
    #   end

    #   it "is true if interest rate is set with 'annually'" do
    #     expect(subject.annually?).to be_truthy
    #   end

    #   it "is true if interest rate is set with 'yearly'" do
    #     subject.interest_rate = '6% yearly'
    #     expect(subject.annually?).to be_truthy
    #   end

    #   it 'is false if interest rate is set with something else' do
    #     subject.interest_rate = '6% monthly'
    #     expect(subject.annually?).to be_falsey
    #   end
    # end
  end
end
