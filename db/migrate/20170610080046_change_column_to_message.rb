class ChangeColumnToMessage < ActiveRecord::Migration[5.0]
  def up
    change_column :messages, :group_id, :integer, null: false
    change_column :messages, :user_id, :integer, null: false
  end

  def down
    change_column :messages, :group_id, :integer, null: true
    change_column :messages, :user_id, :integer, null: true
  end
end
