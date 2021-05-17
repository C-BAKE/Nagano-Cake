class ChangeColumnDefaultToEndUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :end_users, :is_deleted, from: nil, to: "false"
  end
end
