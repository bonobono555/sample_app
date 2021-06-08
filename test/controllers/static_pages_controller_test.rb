require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  # 各テストが実行される直前で実行されるメソッド
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get root" do
    get static_pages_home_url
    assert_response :success
  end


  test "should get home" do
    get static_pages_home_url
    assert_response :success
    # タイトルのテスト
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    # タイトルのテスト
    assert_select "title", "Help | #{@base_title}"
  end

  # 新規テスト
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    # タイトルのテスト
    assert_select "title", "About | #{@base_title}"
  end

  # 問合せページ
  test "should get contract" do
    get static_pages_contract_url
    assert_response :success
    # タイトルのテスト
    assert_select "title", "Contract | #{@base_title}"
  end

end
