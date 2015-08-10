class UsersController < ApplicationController

  before_action :set_variables
  def set_variables
    if current_admin.impersonating_admin.present?
      @current_group = current_admin.impersonating_admin.user_group
      flash.now[:notice] = %Q[Impersonating #{current_admin.impersonating_admin.email}. <a href="/admins/stop_impersonation">Stop impersonation</a>].html_safe
    else
      @current_group = current_admin.user_group
    end
  end

  def index
    @users = User.where(user_group: @current_group)
  end

  def new
    @user = User.new
    @user.user_group = @current_group
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def refresh_users
    @users = User.where(user_group: @current_group)
    @current_group.last_update = Time.now
    @current_group.save()
    @users.each do |user|
      user.update_gmail_stats()
    end
    redirect_to action: "index"
  end

  def populate_users
    if current_admin.impersonating_admin.present?
      @users = User.populate_users(current_admin.impersonating_admin)
    else
      @users = User.populate_users(current_admin)
    end
    redirect_to action: "index"
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

end
