class SearchProduct
  include ActiveModel::Model

  attr_accessor :product_name, :description, :min_price, :max_price

  # product_name
  validates :product_name, presence: false, length: { maximum: 255 }
  # description
  validates :description, presence: false, length: { maximum: 500 }
  # min_price 整数のみ
  validates :min_price,
            presence: false,
            length: { maximum: 10, too_long: '最大%{count}文字まで入力できます' }
            # numericality: { only_integer: true, messages: '数字のみ入力できます' }
  # max_price 整数のみ
  validates :max_price,
            presence: false,
            length: { maximum: 10, too_long: '最大%{count}文字まで入力できます' }
            # numericality: { only_integer: true, messages: '数字のみ入力できます' }

end
