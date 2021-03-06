class SessionsController < ApplicationController
  def new
  end
  
  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if log_in(email, password)
      flash[:success] = 'ログインに成功しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトに成功しました'
    redirect_to root_url
  end
  
  private
  
  def log_in(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      #ログイン成功
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
end
