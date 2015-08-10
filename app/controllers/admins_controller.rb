class AdminsController < ApplicationController
  before_action :authorize_superadmin

  def index
    @admins = Admin.all()
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def impersonate
    current_admin.impersonating_id = params[:admin_id]
    current_admin.save()
    redirect_to controller: "users", action: "index"
  end

  def stop_impersonation
    current_admin.impersonating_id = nil
    current_admin.save()
    redirect_to controller: "users", action: "index"
  end

  private
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

end
