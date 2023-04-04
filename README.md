テーブル設計           

## users_table  

| column                         | type       | options                        | 
| ------------------------------ | ---------- | ------------------------------ |
| nickname                       | string     | null: false                    | 
| email                          | string     | null: false, unique: true      | 
| encrypted_password             | string     | null: false                    | 
| last_name_kanji                | string     | null: false                    | 
| first_name_kanji               | string     | null: false                    | 
| last_name_kana                 | string     | null: false                    | 
| first_name_kana                | string     | null: false                    | 
| birthday                       | date       | null: false                    | 

### Association
* has_many :items 
* has_many :purchases 

## items_table

| column                         | type       | options                        | 
| ------------------------------ | ---------- | ------------------------------ |
| items_name                     | string     | null: false                    | 
| description                    | text       | null: false                    | 
| category                       | integer    | null: false                    | 
| condition                      | integer    | null: false                    | 
| shipping_burden                | integer    | null: false                    | 
| shipping_from                  | integer    | null: false                    | 
| shipping_days                  | integer    | null: false                    | 
| price                          | integer    | null: false                    | 
| user                           | references | null: false, foreign_key: true | 

### Association
* belongs_to :user
* has_one :purchases

## shipping_destinations_table

| column                         | type       | options                        | 
| ------------------------------ | ---------- | ------------------------------ |
| postal_code                    | string     | null: false                    | 
| prefecture                     | integer    | null: false                    | 
| city                           | string     | null: false                    | 
| address1                       | string     | null: false                    | 
| address2                       | string     |                                | 
| phone_number                   | string     | null: false                    | 
| purchase                       | references | null: false, foreign_key: true | 

### Association
* belongs_to :purchases

## purchases_table

| column                         | type       | options                        | 
| ------------------------------ | ---------- | ------------------------------ |
| user                           | references | null: false, foreign_key: true | 
| item                           | references | null: false, foreign_key: true | 

### Association
* belongs_to :user
* belongs_to :item
* has_one :shipping_destinations


