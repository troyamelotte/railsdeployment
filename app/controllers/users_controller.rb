class UsersController < ApplicationController
  def register
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user] = user.id
      redirect_to '/secrets/index'
    else
      flash[:alert] = user.errors.full_messages
      redirect_to '/users/register'
    end
  end

  def login
  end

  def logout
    session.delete(:user)
    redirect_to '/'
  end

  def checkuser
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user.id
      puts 'test'
      redirect_to '/secrets/index'
    else
      flash[:alert] = 'Invalid user/password'
      redirect_to '/users/login'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
