include ActionDispatch::TestProcess
require "faker"

FactoryGirl.define do

  factory :message do
    body      Faker::Lorem.sentence
    image     File.open(Rails.root.join("spec/factories/images/r2d2.png"))
    group_id  Faker::Number.between(1, 100)
    user_id   Faker::Number.between(1, 100)
  end

end
