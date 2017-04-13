FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com"}
  factory :user do
    email
    password 'password'
    first_name 'David'
    last_name 'Bowie'
    admin false
  end
  factory :admin, class: User do
    email
    password 'password'
    first_name 'Jimi'
    last_name 'Hendrix'
    admin true
  end
end
