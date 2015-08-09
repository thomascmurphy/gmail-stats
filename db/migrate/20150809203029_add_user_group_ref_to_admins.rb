class AddUserGroupRefToAdmins < ActiveRecord::Migration
  def change
    add_reference :admins, :user_group, index: true, foreign_key: true
  end
end
