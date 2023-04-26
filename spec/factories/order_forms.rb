FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    shipping_from_id { 2 }
    city { '東京都' }
    address1 { '渋谷区道玄坂1-1-1' }
    address2 { '渋谷ビルディング' }
    phone_number { '09012345678' }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
