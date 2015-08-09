class AddUserGroupRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_group, index: true, foreign_key: true
  end
end
