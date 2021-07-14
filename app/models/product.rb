class Product < ApplicationRecord
  # product_name
  validates :product_name, presence: true, length: { maximum: 255 }
  # description
  validates :description, presence: false, length: { maximum: 500 }
  # price 整数のみ
  validates :price,
            presence: { message: '必須です' }, # TODO: メッセージを外だしする
            length: { maximum: 10, too_long: '最大%{count}文字まで入力できます' },
            numericality: { only_integer: true, messages: '数字のみ入力できます' }
  # image_url
  validates :image_url, presence: false, length: { maximum: 500 }

  # 商品1件登録
  def createProduct(productObject)
    # トランザクション
    transaction do
      logger.info 'DB登録開始'
      productObject.save! # save!は無効な場合、例外を返す # TODO 例外発生した場合意図したエラーjsonレスポンスを返したい
    end
    # TODO 2つ以上の更新メソッドがあった場合、2つ目が失敗した場合、例外発生かつロールバックされるか確認する
  rescue => e
    logger.error 'DB登録失敗'
    logger.error "#{e.class} / #{e.message}"
    # logger.error e.backtrace.join("\n") 
    return false
  end

  # 商品検索
  def searchProduct searchParams

    sql = " SELECT * FROM products "

    if searchParams.key?("product_name") || searchParams.key?("description") || searchParams.key?("min_price") || searchParams.key?("max_price")
      sql << " WHERE product_name LIKE ? OR description LIKE ? OR price >= ? OR price <= ? LIMIT ?"
    end

    # TODO マジックナンバーをconfigなどへ退避させる
    bResult = Product.find_by_sql([sql, searchParams[:product_name], searchParams[:description], searchParams[:min_price], searchParams[:max_price], 10])

    # =====================================================
    # # TODO sqlインジェクション対策がされているかつ、 速いかつ、sql直書きにベストなメソッドは？
    # # ①execute使用、SQLインジェクション対策のためサニタイズ利用
    # aSql = "select * from products where id = ? limit ?"
    # aSanitizedSql = Product.sanitize_sql_array([aSql, 1, 10])
    # aResult = Product.connection.execute(aSanitizedSql)
    # logger.info "1つめ"
    # logger.info aResult[0]["id"]
    #
    # # ②find_by_sql使用、SQLインジェクション対策のためプレースフォルダ使用
    # bResult = Product.find_by_sql(['select * from products where id = ? limit ?', 1, 10])
    # logger.info "2つめ"
    # logger.info bResult[0].id
    #
    # #③select_all使用、SQLインジェクション対策のためサニタイズ利用
    # cSql = "select * from products where id = ? limit ?"
    # cSanitizedSql = Product.sanitize_sql_array([aSql, 1, 10])
    # cResult = Product.connection.select_all(cSanitizedSql)
    # logger.info "3つめ"
    # logger.info cResult[0]["id"]
    # =====================================================

  end

end
