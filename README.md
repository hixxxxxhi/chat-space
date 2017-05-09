# DB設計
- 参考にしたページ：http://qiita.com/Kohei_Kishimoto0214/items/cb9a3d3da57708fb52c9

## messages table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| body         |    text    | null: false                              |
| image        |   string   |                                          |
| group_id     |   integer  | references :group, foreign_key: true     |
| user_id      |   integer  | references :user, foreign_key: true      |

## Association
- belongs_to :user
- belongs_to :group

## users table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| name         |   string   | null: false                              |
| email        |   string   | null: false, unique: true                |
| ...          |    ...     | ...                                      |
- 実際にはdeviseを導入して`bundle exec rails g devise User`と`bundle exec rake db:migrate`でデータベースを作成する。

## Association
- has_many :messages
- has_many :groups, through: :members
- has_many :members

## groups table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| name         |   string   | null: false, unique: true                |

## Association
- has_many :messages
- has_many :users, through: :members
- accepts_nested_attributes_for :members

## members table
|    Column    |    Type    |                      Options                       |
|:-------------|:----------:|:---------------------------------------------------|
| user_id      |   integer  | references :user, foreign_key: true, index: true   |
| group_id     |   integer  | references :group, foreign_key: true, index: true  |

## Association
- belongs_to :user
- belongs_to :group
