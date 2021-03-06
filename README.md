# DB設計
- 参考にしたページ：http://qiita.com/Kohei_Kishimoto0214/items/cb9a3d3da57708fb52c9

## messages table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| body         |    text    | null: false                              |
| image        |   string   |                                          |
| group_id     |   integer  |                                          |
| user_id      |   integer  |                                          |

## Association
- belongs_to :user
- belongs_to :group

## users table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| name         |   string   | null: false, index: true, unique: true   |

## Association
- has_many :messages
- has_many :groups, through: :group_users
- has_many :group_users

## groups table
|    Column    |    Type    |                 Options                  |
|:-------------|:----------:|:-----------------------------------------|
| name         |   string   | null: false, unique: true                |

## Association
- has_many :messages
- has_many :users, through: :group_users
- has_many :group_users

## group_users table
|    Column    |    Type    |                      Options                       |
|:-------------|:----------:|:---------------------------------------------------|
| user_id      |   integer  |                                                    |
| group_id     |   integer  |                                                    |

## Association
- belongs_to :user
- belongs_to :group
