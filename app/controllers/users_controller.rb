class UsersController < ApplicationController

  def index
    if admin_signed_in?
      @current_group = current_admin.user_group
      @users = User.where(user_group: @current_group)
      @updated_time = Time.now.localtime
      @updated_time_string = @updated_time.strftime("%e %b %Y %k:%M")
      @users.each do |user|
        user.update_gmail_stats()
      end
    else
      @users = []
    end
  end

  def new
    if admin_signed_in?
      @current_group = current_admin.user_group
      @user = User.new
      @user.user_group = @current_group
    else
      @user = nil
    end
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
    @users = User.refresh_users(current_admin)
    redirect_to action: "index"
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

end
