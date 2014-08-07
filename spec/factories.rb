FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :flight do
    airline
    departure_airport
    arrival_airport
    departure_scheduled (Time.now)
    departure_actual (Time.now)
    arrival_scheduled (Time.now + (60 * 60))
    arrival_actual (Time.now + (60 * 60))
  end

  factory :post do
    user
    flight
    satisfaction (true)
    text ("Sweet flight BREH")
  end
end


