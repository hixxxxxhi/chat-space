require 'rails_helper'

describe Message do
  describe '#create' do
    context 'normal scenarios where a message can be saved' do
      it "is valid with a body" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end

      it "is valid with an image" do
        message = build(:message, body: nil)
        expect(message).to be_valid
      end

      it "is valid with a body and image" do
        message = build(:message)
        expect(message).to be_valid
      end
    end

    context 'abnormal scenarios where a message cannot be saved' do
    end
  end
end
