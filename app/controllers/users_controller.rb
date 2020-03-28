class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録でログインする(セッションにidを渡す。)
      log_in @user
      # flashメッセージの表示(success)
      flash[:success] = "Welcome to the Sample App!"
      # @userによって、該当するuser_idのページへ遷移
      redirect_to @user
    else
      render 'new'
    end
  end

private

  #StrongParameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end