include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :message do
    body      "Hello"
    image     File.open(Rails.root.join("spec/factories/images/r2d2.png"))
    group_id  36
    user_id   1
  end

end
