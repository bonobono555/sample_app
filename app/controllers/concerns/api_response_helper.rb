# API側エラーレスポンス
module ApiResponseHelper

  def render_internal_server_error
    render status: "FAILED", json: { status: 500, message: '予期せぬエラー発生ー' }, status: 500
  end

  def render_not_found
    render status: :not_found, json: { status: 400, message: '存在しないリソースです' }
  end
end
