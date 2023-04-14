FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.email }
    password = "1a#{Faker::Internet.password(min_length: 6)}"
    password { password }
    password_confirmation { password }
    nickname { Faker::Internet.username }
    birthday { Faker::Date.between_except(from: '2014-09-23', to: '2015-09-25', excepted: '2015-01-24') }
    first_name_kanji { person.first.kanji }
    last_name_kanji { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
  end
end
