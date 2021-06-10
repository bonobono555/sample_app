require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  # 各テストが実行される直前で実行されるメソッド
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get help" do
    get helpp_path
    assert_response :success
    # タイトルのテスト
    assert_select "title", "Help | #{@base_title}"
  end

  # 新規テスト
  test "should get about" do
    get about_path
    assert_response :success
    # タイトルのテスト
    assert_select "title", "About | #{@base_title}"
  end

  # 問合せページ
  test "should get contract" do
    get contract_path
    assert_response :success
    # タイトルのテスト
    assert_select "title", "Contract | #{@base_title}"
  end

  # コンタクト
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
  
end
