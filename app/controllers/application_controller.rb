class ApplicationController < ActionController::Base
    PER_PAGE = 20
    BASE_URL = "http://appeight.netdemo.in/"  
    TOKEN = '179fb286-74c2-4b19-ba0d-53c7484518c5'
  
    helper_method :current_user
    
    def current_user
      if cookies.signed[:token] == TOKEN
        @current_user = 'admin'
      end
      #@current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end  
  
    def authorize
      redirect_to '/login' unless current_user
    end
end
