class AddRefreshDateToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :last_update, :datetime
  end
end
