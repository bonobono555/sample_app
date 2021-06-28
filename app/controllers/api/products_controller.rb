class Api::ProductsController < ApplicationController
  require "./app/request/search_product"
  # ユーザー一覧取得
  def index
    @product = Product.paginate(page: params[:page])
    render json: {status: 'SUCCESS', message: '成功', data: @product}, status: :ok
  end

  # ユーザー詳細取得
  def show
    @product = Product.find(params[:id])
    render json:{status: "SUCCESS", message: '成功', data: @product}, status: :ok
  end

  # ユーザー登録
  def create
    @product = Product.new(product_params)
    # 入力値のバリデーション実行
    unless @product.valid?
      # バリデーションメッセージの存在確認を行う　TODO 通常行うのか？
      unless @product.errors.messages.blank?
        # renderは複数回書いてはだめなのでand returnを最後につける
        render json: @product.errors.messages, status: 503 and return 
      else
        # TODO 文字列外だし、通過するかのテスト実施
        render json: {status: "FAILED", mesasge: "失敗", data: "意図しないエラー発生"}, status: 500 and return 
      end
    end

    # 入力値の整形あるかも ex.image_urlをs3のpathに変換とか

    if @product.createProduct @product
      render json: { stauts: "SUCCESS", mesasge: "成功" }, status: 201 and return
    else 
      # TODO DB登録失敗時、contorollerで分岐させず、modelで例外発生した時点でjsonエラーレスポンスを返したい
      render json: { stauts: "FAILED", mesasge: "失敗" }, status: 500
    end

  end


  # 商品検索
  def search
    # TODO Productクラスで定義したバリデーションと異なるバリデーションを行いたい場合のベストプラクティス
    @searchProduct = SearchProduct.new(search_product_params)
    # 入力値のバリデーション実行
    unless @searchProduct.valid?
      # バリデーションメッセージの存在確認を行う
      unless @searchProduct.errors.messages.blank?
        render json: @searchProduct.errors.messages, status: 503 and return 
      else
        render json: {status: "FAILED", mesasge: "失敗", data: "意図しないエラー発生"}, status: 500 and return 
      end
    end

    @product = Product.new
    @searchProductList = @product.searchProduct @searchProduct

    render json: { stauts: "SUCCESS", mesasge: "検索成功", data: @searchProductList }, status: 200 and return
  end

  private
    # Strong Parameters設定　必須パラメーターを設定
    def product_params
      params.require(:product).permit(:product_name, :description, :price, :image_url)
    end

    # 検索API　Strong Parameters設定 
    # fetch:リクエストにルートキーがないためrequireではなくfetchを使用
    # リクエスト内容全て許可するためpermit()ではなく、permit!を使用
    def search_product_params
      params.fetch(:search_product, {}).permit! 
    end
    
end