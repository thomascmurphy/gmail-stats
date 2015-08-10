class AddSuperAdminToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :superadmin, :boolean, :default => false
    add_column :admins, :impersonating_id, :integer
  end
end
