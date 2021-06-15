class SessionsController < ApplicationController
  
  # ログインページ表示
  def new
  end

  # ログイン実行
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    # 「&.」ぼっち演算子　userがnilでないときに、authenticate()を呼び出す
    # if user && user.authenticate(params[:session][:password])の書き換えが下記になる
    if user&.authenticate(params[:session][:password])
      
      # ユーザーログイン処理実行
      log_in user
      # ログイン情報記憶 三項演算子を利用
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # リダイレクトさせる
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # ログアウト処理
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
