class ApplicationController < ActionController::Base
    
    # Sessionヘルパーモジュールを読み込む
    include SessionsHelper

    def hello
        render html: "hello, world!"
    end

end
