module MovieApp
    module V1
      class Userdetails < Grape::API
        include MovieApp::V1::Defaults      
  
        ##################################################################
        # No1 => V1 user Sign In Api
        ##################################################################
        resource :userSignin do
          desc "User Sign In API"
          before {api_params}        
  
          params do
            requires :deviceId, type: String, allow_blank: false
            optional :deviceType, type: String, allow_blank: true
            optional :deviceName, type: String, allow_blank: true
  
            requires :socialType, type: String, allow_blank: false
            requires :socialId, type: String, allow_blank: false
            optional :socialToken, type: String, allow_blank: false        
  
            optional :socialEmail, type: String, allow_blank: true
            optional :socialName, type: String, allow_blank: true
            optional :socialImgurl, type: String, allow_blank: true        
  
            optional :advertisingId, type: String, allow_blank: true        
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false
  
            optional :utmSource, type: String, allow_blank: true
            optional :utmMedium, type: String, allow_blank: true
            optional :utmTerm, type: String, allow_blank: true
            optional :utmContent, type: String, allow_blank: true
            optional :utmCampaign, type: String, allow_blank: true
            optional :mobileNumber, type: String, allow_blank: true
          end
          
          post do
            begin
              source_ip = env['REMOTE_ADDR'] || env['HTTP_X_FORWARDED_FOR']
              location_ip = env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR']
  
              genuine_user = true #google_validator(params['socialToken'], params['socialEmail'])            
              if genuine_user == false
                logger.info "API Exception-BLOCK-GLV:#{Time.now}-userSignin-#{params.inspect}"
                {message: GBLOCKED, status: 500}
              else
                source_ip_count = User.where(source_ip: source_ip).count
                location_ip_count = User.where(location: location_ip).count
  
                if source_ip_count > MAX_IP_COUNT
                  logger.info "API Exception-BLOCK-IPS:#{Time.now}-userSignin-#{params.inspect}"
                  {message: BLOCKED, status: 500}
                elsif location_ip_count > MAX_IP_COUNT
                  logger.info "API Exception-BLOCK-IPL:#{Time.now}-userSignin-#{params.inspect}"
                  {message: BLOCKED, status: 500}  
                else
                  user = User.where(social_id: params['socialId']).or(User.where(mobile_no: params['mobileNo'])).first_or_initialize            
                  refCode = SecureRandom.hex(4).upcase
                  utm_medium = params['utmMedium']                
                            
                  if user.new_record?
                    user.update(referral_code: refCode, social_email: params['socialEmail'], social_type: params['socialType'],
                     social_name: params['socialName'], social_imgurl: params['socialImgurl'], device_type: params['deviceType'],
                     device_name: params['deviceName'], advertising_id: params['advertisingId'], version_name: params['versionName'],
                     version_code: params['versionCode'], security_token: SecureRandom.uuid, fcm_token: params['fcmToken'], social_token: params['referrerUrl'],
                     device_id: params['deviceId'], location: location_ip, source_ip: source_ip, utm_source: params['utmSource'], utm_medium: utm_medium, mobile_number: params['mobileNumber'])
                    #Only New User Bonus
                    # Transaction.create(user_id: user.id, trans_name: 'SignUp Bonus', trans_type: 'SIGNUP', trans_amount: INVITE_COIN)
                    # Account.create(user_id: user.id, coin_balance: INVITE_COIN, amount_balance: INVITE_AMT)
                    # UserProfile.create(user_id: user.id, name: params[:socialName], email: params[:socialEmail], image: params[:socialImgurl])
                    {status: 200, message: MSG_SUCCESS, userId: user.id, securityToken: user.security_token, userImageUrl: user.social_imgurl}
                  else
                    user.update(social_email: params['socialEmail'], social_type: params['socialType'], utm_medium: params['utmMedium'],
                     social_name: params['socialName'], social_imgurl: params['socialImgurl'], device_type: params['deviceType'],
                     device_name: params['deviceName'], advertising_id: params['advertisingId'], version_name: params['versionName'],
                     version_code: params['versionCode'], fcm_token: params['fcmToken'], social_token: params['referrerUrl'],
                     device_id: params['deviceId'], location: location_ip, source_ip: source_ip, utm_source: params['utmSource'], mobile_number: params['mobileNumber'])
                     {status: 200, message: MSG_SUCCESS, userId: user.id, securityToken: user.security_token, userImageUrl: user.social_imgurl}
                  end                
                end
              end  
                
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-userSignin-#{params.inspect}-Error-#{e}"          
              {message: MSG_ERROR, status: 500}          
            end
          end
        end 
  
        ##################################################################
        # => V1 user Sign Up Api
        ##################################################################
        # resource :userSignup do
        #   desc "User Sign Up API"
        #   before {api_params}
  
        #   params do
        #     requires :deviceId, type: String, allow_blank: false
        #     optional :deviceType, type: String, allow_blank: true
        #     optional :deviceName, type: String, allow_blank: true
  
        #     requires :socialType, type: String, allow_blank: false
        #     requires :socialId, type: String, allow_blank: false
        #     optional :socialToken, type: String, allow_blank: false        
  
        #     optional :socialEmail, type: String, allow_blank: true
        #     optional :socialName, type: String, allow_blank: true
        #     optional :socialImgurl, type: String, allow_blank: true        
  
        #     optional :advertisingId, type: String, allow_blank: true        
        #     requires :versionName, type: String, allow_blank: false
        #     requires :versionCode, type: String, allow_blank: false
  
        #     optional :utmSource, type: String, allow_blank: true
        #     optional :utmMedium, type: String, allow_blank: true
        #     optional :utmTerm, type: String, allow_blank: true
        #     optional :utmContent, type: String, allow_blank: true
        #     optional :utmCampaign, type: String, allow_blank: true
        #   end
          
        #   post do
        #     begin
        #       source_ip = env['REMOTE_ADDR'] || env['HTTP_X_FORWARDED_FOR']
        #       location_ip = env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR']
  
        #       genuine_user = true#google_validator(params['socialToken'], params['socialEmail'])            
        #       if genuine_user == false
        #         logger.info "API Exception-BLOCK-GLV:#{Time.now}-userSignup-#{params.inspect}"
        #         {message: GBLOCKED, status: 500}
        #       else      
        #         {status: 200, message: MSG_SUCCESS, userId: '1', securityToken: '32124-da55235-3211gfH-H45df99n', socialImgurl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80'}
        #       end  
        #     rescue Exception => e
        #       logger.info "API Exception-#{Time.now}-userSignup-#{params.inspect}-Error-#{e}"          
        #       {message: MSG_ERROR, status: 500}          
        #     end
        #   end
        # end
  
  
        ##################################################################
        # => V1 user app open api
        ##################################################################
        resource :appOpen do
          desc "App Open API"
          before {api_params}
  
          params do
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false
          end
  
          post do
            begin
                user = valid_user(params['userId'].to_i, params['securityToken'])
            if user
              force_update = false
              if (params['versionName'] != '1.9' && params['versionCode'] != '10')
                force_update = false
              end
              # attendence = [true,true].sample
              source_ip = env['REMOTE_ADDR'] || env['HTTP_X_FORWARDED_FOR']            
              location = source_ip #Geocoder.address(source_ip)            
              Appopen.create(user_id: user.id,source_ip: source_ip, location: location, version_name: params['versionName'], version_code: params['versionCode'])
              #invite amount logic
              # if(user.appopens.count == 1 && user.created_at.to_datetime > DateTime.now-1)
              #   advertid_count = User.where(advertising_id: user.advertising_id).count
              #   if advertid_count == 1
              #     referee = User.where(referral_code: user.utm_medium).first
              #     if referee
              #       invite_count = User.where("utm_medium = ?", referee.referral_code).count
              #       # if invite_count < 15
              #       #   Transaction.create(user_id: referee.id, trans_name: "Invited:#{user.social_name}", trans_type: 'INVITE', trans_amount: INVITE_COIN)                  
              #       #   update_wallet(referee.id, INVITE_COIN, 'add')
              #       # else
              #         # luck = [false,true].sample
              #         # if luck == true
              #         #   Transaction.create(user_id: referee.id, trans_name: "Invited:#{user.social_name}", trans_type: 'INVITE', trans_amount: INVITE_COIN)                  
              #         #   update_wallet(referee.id, INVITE_COIN, 'add')
              #         # end  
              #       end  
              #     # else
              #     #   require "uri"
              #     #   require "net/http"                    
              #     #   uri = URI("https://mobtrack.app/postbacks/record?vendor=MGApps&app=Pic2word&clickid=#{user.utm_medium}&adv_sub=#{user.utm_gclid}")
              #     #   x = Net::HTTP.get(uri)
              #     end
              #   end  
              # end
                {message: MSG_SUCCESS, status: 200, forceUpdate: force_update, vipStatus: [true,false].sample ,appUrl: "https://statussavvy.app/invite/#{user.referral_code}" }
              else
                {message: INVALID_USER, status: 500}
              end  
  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-appOpen-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
  
      
  
        ##################################################################
        # => V1 Invite Page
        ##################################################################
        resource :appInvite do
          desc "Invite Page API"
          before {api_params}
  
          params do
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false        
          end
  
          post do
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])
              if user
                # inviteText = "Get 500 rewards points for you and your friends!"
                inviteFbUrl = "https://statussavvy.app/invite/#{user.referral_code}/?by=facebook"
                referralLink = "https://rewardstar.app/invite/#{user.referral_code}"
                # inviteImgurl = "https://braveryportal.com/wp-content/uploads/2021/06/Paypal-Referal-1024x576.png"
                inviteTextUrl = "Download Rewardstar App and get free Paytm/Paypal Cashback upto Rs.500, Click here: https://statussavvy.app/invite/#{user.referral_code}/?by=social"
                inviteData= [
                  { 
                    imageLink: "https://cdn-icons-png.flaticon.com/128/3018/3018421.png",
                    inviteText: "Your friend should join with your referral link."
                  },
                  {
                    imageLink: "https://cdn-icons-png.flaticon.com/128/10381/10381214.png",
                    inviteText: "After joining Rewardstar App, your friend will earn coins."
                  },
                  {
                    imageLink: "https://cdn-icons-png.flaticon.com/128/8929/8929782.png",
                    inviteText: "You will be getting 10% of his earning for the first month."
                  }
                ]
                {message: MSG_SUCCESS, status: 200, inviteCoin: '200', userCoin: user.account.coin_balance, referralLink: referralLink, inviteFbUrl: inviteFbUrl, inviteTextUrl: inviteTextUrl, inviteData: inviteData}
              else
                {message: INVALID_USER, status: 500}
              end  
  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-appInvite-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
  
  
        
        resources :editProfile do
          desc "Api to add to favorites and watchlist"
          before{api_params}
  
          params do 
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false
            requires :actionType, type: String, allow_blank: false
            optional :name, type: String, allow_blank: true
            optional :age, type: String, allow_blank: true
            optional :gender, type: String, allow_blank: true
            optional :email, type: String, allow_blank: true
            optional :mobileNumber, type: String, allow_blank: true
  
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user
                # user = User.find_by_id(params[:userId].to_i)
                up=UserProfile.find_by(user_id: params[:userId].to_i)
                if params[:actionType] == "post"   
                  if params[:photo].present?
                    photo_data=params[:photo]
                    filename=photo_data[:filename]
                    tempfile=photo_data[:tempfile]
                    # up.image.attach(params[:photo])
                    up.photo.attach(io: tempfile, filename: photo_data[:filename])
                    up.update(name: params[:name], age: params[:age], gender: params[:gender], email: params[:email], mobile_number: params[:mobileNumber])
                  else
                    up.update(name: params[:name], age: params[:age], gender: params[:gender], email: params[:email], mobile_number: params[:mobileNumber])
                  end
                  if up.photo.attached?
                    image_url ="http://appeight.netdemo.in/" + Rails.application.routes.url_helpers.rails_blob_path(up.photo, only_path: true)
                  else
                    image_url = nil
                  end
                  userDetails = {name: up.name, email: user.social_email, image: image_url.present? ? image_url : user.social_imgurl}
                  {message: MSG_SUCCESS, status: 200 , userDetails: userDetails}
                else
                  if up.photo.attached?
                    image_url ="http://appeight.netdemo.in/" + Rails.application.routes.url_helpers.rails_blob_path(up.photo, only_path: true)
                  else
                    image_url = nil
                  end
                  userDetails = 
                  {
                    name: up.name.present? ? up.name : user.social_name, 
                    image: image_url.present? ? image_url : user.social_imgurl, 
                    email: user.social_email,
                    age: up.age.present? ? up.age : "",
                    gender: up.gender.present? ? up.gender : "", 
                    mobileNumber: up.mobile_number.present? ? up.mobile_number :  ""
                  }
                  {message: MSG_SUCCESS, status: 200, userDetails: userDetails}
                end
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-shortsList-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
      end
    end
  end