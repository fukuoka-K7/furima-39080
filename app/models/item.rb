class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_burden
  belongs_to :shipping_day
  belongs_to :shipping_from

  validates :image,             presence: true
  validates :item_name,         presence: true
  validates :description,       presence: true
  validates :price,             presence: true, numericality: { only_integer: true }, inclusion: { in: 300..9_999_999 }

  with_options numericality: { other_than: 1 } do
    validates :category_id, :shipping_from_id, :condition_id, :shipping_burden_id, :shipping_day_id
  end
end
