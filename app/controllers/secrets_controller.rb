class SecretsController < ApplicationController
  def index
    redirect_to '/' unless session[:user]
    @secrets = Secret.all
  end

  def create
    redirect_to '/' unless session[:user]
    @user_secrets = User.find(session[:user]).secrets
    @secrets_liked = User.find(session[:user]).secrets_liked
  end

  def new
    secret = Secret.new(secret: params[:secret], total_likes: 0, user_id: session[:user])
    secret.save
    redirect_to '/secrets/index'
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user_id ==session[:user]
    redirect_to '/secrets/create'
  end

  def like
    secret = Secret.find(params[:id])
    secret.total_likes +=1
    secret.save
    Like.create(secret_id:secret.id, user_id:session[:user])
    redirect_to '/secrets/index'
  end
end
