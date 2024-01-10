module MovieApp
    module V1
      module Defaults
        require 'openssl'
        extend ActiveSupport::Concern
        NEW_USER_AMT = 10
        INVITE_AMT = 5
        INVITE_COIN = 500
        MAX_IP_COUNT = 3      
        BASE_URL = "https://appnine.netdemo.in"
        # BASE_URL = "http://localhost:3000"
        MSG_SUCCESS = "Success"
        MSG_ERROR = "Internal Server Error"
        BLOCKED = "You Blocked, Max Limit"
        INVALID_USER = 'Invalid UserId/Token'
        GBLOCKED = "Sorry! Scripts/Tricks not Allowed"
  
        included do
          prefix 'api'
          version 'v1', using: :path
          default_format :json
          format :json
          #formatter :json, Grape::Formatter::ActiveModelSerializers
  
          helpers do
            def permitted_params
              @permitted_params ||= declared(params, include_missing: false)
            end
  
            def api_params
              Rails.logger.info"API Params:#{params.inspect}"
            end
  
            def logger
              Rails.logger
            end
  
            def fire_mobtrack_postback(utmMedium, referalUrl)
              begin
                require "uri"
                require "net/http"
                mobtrack_url = "https://mobtrack.app/postbacks/record?vendor=MGApps&app=TrendyNews&clickid=#{utmMedium}&adv_sub=#{referalUrl}"
                uri = URI(mobtrack_url)        
                response = Net::HTTP.get_response(uri)
                return true
              rescue Exception => e
                logger.info "++MobtrackPB Error:#{e}"
                return false
              end            
            end          
  
            def valid_user(user_id, security_token)
              user = User.find_by(id: user_id.to_i, security_token: security_token)
              if user
                return user
              else
                return false
              end
            end
  
            def valid_appuser(user_id, security_token)
              user = AppUser.where("id = ? AND security_token = ?", user_id, security_token).first
              if user          
                return user
              else
                return false
              end
            end



            def encrypt_string(text, key)
              cipher = OpenSSL::Cipher.new('AES-256-CBC')
              cipher.encrypt
              cipher.key = key
              encrypted = cipher.update(text) + cipher.final
              return Base64.strict_encode64(encrypted)
            end

            def decrypt_string(encrypted_text, key)
              decipher = OpenSSL::Cipher.new('AES-256-CBC')
              decipher.decrypt
              # decipher.key = Base64.strict_decode64(key)
              decipher.key = key
              decrypted = decipher.update(Base64.strict_decode64(encrypted_text)) + decipher.final
              return decrypted
            end











  
            def update_wallet(user_id, coin_amount, mode)
              user = User.find(user_id.to_i)
              if user
                coin_balance = user.account.coin_balance
                if mode == 'minus'
                  updated_coin_balance = coin_balance.to_i - coin_amount.to_i
                else
                  updated_coin_balance = coin_balance.to_i + coin_amount.to_i
                end
                updated_amount_balance = updated_coin_balance.to_f/100
                user.account.update(coin_balance: updated_coin_balance, amount_balance: updated_amount_balance)          
                return true
              else
                return false
              end            
            end
  
            def google_validator(token, socialemail)
              validator = GoogleIDToken::Validator.new(expiry: 300)
              begin
                token_segments = token.split('.')
                if token_segments.count == 3
                  #optional_client_id = 473754589992-sp8t4j084skt894hb2gvc6mno2933qs7.apps.googleusercontent.com'               
                  required_audience = JWT.decode(token, nil, false)[0]['aud']
                  payload = validator.check(token, required_audience)                
                  #payload = validator.check(token, required_audience, optional_client_id)              
                  logger.info "++Payload Email:#{payload['email']}|ApiEmail:#{socialemail}"
                  logger.info "Payload Params:#{payload}"                
                  if(payload['email'] == socialemail) #&& (payload['azp'].include? "473754589992")
                    return true
                  else
                    return false
                  end
                else
                  return false
                end     
              rescue GoogleIDToken::ValidationError => e
                logger.info "++Validator Error:#{e}"
                return false                
              end  
            end      
          end
  
          rescue_from ActiveRecord::RecordNotFound do |e|
            error_response(message: e.message, status: 404)
          end
  
          rescue_from ActiveRecord::RecordInvalid do |e|
            error_response(message: e.message, status: 422)
          end
        end
      end
    end
end