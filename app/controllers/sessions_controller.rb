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
      
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # ログアウト処理
  def destroy
    log_out
    redirect_to root_url
  end
end
