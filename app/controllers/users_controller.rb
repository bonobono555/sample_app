class UsersController < ApplicationController
  # index,edit,update,destroyメソッドの場合、先にログイン済か確認する
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # edit,updateメソッドの場合、先に正しいユーザーかどうか確認する
  before_action :correct_user,   only: [:edit, :update]
  # 管理者のみdestroyメソッドを実行できる
  before_action :admin_user,     only: :destroy

  # ユーザー一覧画面
  def index
    @users = User.paginate(page: params[:page])
  end

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

  # ユーザー情報編集画面表示
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー情報更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合
      flash[:success] = "Profileが更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # ユーザーを削除する
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    # 許可された属性リスト adminが含まれていないことがセキュリティ的に重要
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # アクセスしようとしたURLを覚えておく
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      
      # 書き換えた
      # redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
