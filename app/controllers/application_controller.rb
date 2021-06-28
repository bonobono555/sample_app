class ApplicationController < ActionController::API
    
    # Sessionヘルパーモジュールを読み込む
    include SessionsHelper

    def hello
        render html: "hello, world!"
    end

end
