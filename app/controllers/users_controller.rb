class UsersController < ApplicationController

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    
    # ↓コンソール画面でデバッグすることができる
    # debugger
  end

  # ユーザーフォーム入力画面
  def new
    @user = User.new
  end

  # ユーザー登録
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end


end
