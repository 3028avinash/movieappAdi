module MovieApp
  class Base < Grape::API
    mount MovieApp::V1::Userdetails
    mount MovieApp::V1::Appdetails
    mount MovieApp::V1::Appdatalist
  end
end