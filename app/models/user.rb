class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :first_name_kanji, presence: true
    validates :last_name_kanji, presence: true
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角(カタカナ)を使用してください' } do
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
  end
  validates :birthday, presence: true

  has_many :items
  has_many :orders
end
