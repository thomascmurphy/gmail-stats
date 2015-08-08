class UsersController < ApplicationController

  def index
    @users = User.all
    @updated_time = Time.now
    @updated_time_string = @updated_time.strftime("%e %b %Y %k:%M")
    @users.each do |user|
      user.update_gmail_stats()
    end
  end

  def new
    @user = User.new
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
    @users = User.refresh_users()
    redirect_to action: "index"
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

end
