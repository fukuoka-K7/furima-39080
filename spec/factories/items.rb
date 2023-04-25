FactoryBot.define do
  factory :item do
    association :user

    item_name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 10) }
    condition_id { Faker::Number.between(from: 2, to: 6) }
    shipping_burden_id { Faker::Number.between(from: 2, to: 3) }
    shipping_from_id { Faker::Number.between(from: 2, to: 47) }
    shipping_day_id { Faker::Number.between(from: 2, to: 3) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end
