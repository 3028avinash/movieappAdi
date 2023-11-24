module MovieApp
    class Base < Grape::API
        mount MovieApp::V1::Userdetails
        mount MovieApp::V1::Appdetails
    #   mount CashApp::V1::Gameplays
    end
end