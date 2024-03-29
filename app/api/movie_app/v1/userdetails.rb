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
                  user = User.where(social_id: params['socialId']).or(User.where(mobile_number: params['mobileNumber'])).first_or_initialize            
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
                { message: MSG_SUCCESS, status: 200, forceUpdate: force_update, primeUser: user.subscription_histories.exists?(status: 'active'), appUrl: "https://statussavvy.app/invite/#{user.referral_code}", userImageUrl: user.profile.image_url, mobile: user.profile.mobile, name: user.profile.name }
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
          desc "Api to editProfile and show profile data"
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
            optional :mobileNumber, type: String, allow_blank: true
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user
                if params[:actionType] == "post"
                  update_data = {
                    name: params[:name] ? params[:name] : user.profile.name,
                    age: params[:age] ? params[:age] : user.profile.age,
                    gender: params[:gender] ? params[:gender] : user.profile.gender,
                    mobile: params[:mobileNumber] ? params[:mobileNumber] : user.profile.mobile,
                  }
                  user.profile.update(update_data)
                  {message: MSG_SUCCESS, status: 200, data: 'Updated Successfully'}
                elsif params[:actionType] == 'get'
                  { message: MSG_SUCCESS, status: 200, data: user.profile.attributes.slice('name', 'age', 'gender', 'mobile') }
                end
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-editProfile-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
  
  
        
        resources :uploadImage do
          desc "Api to upload profile image"
          before{api_params}
  
          params do 
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false

            requires :profileImage, type: File, allow_blank: false
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user

              uploaded_file = params[:profileImage]

                if params[:profileImage].present? && uploaded_file[:type].in?(%w(image/jpeg image/jpg image/png image/gif image/*))
                  user.profile.image.attach(
                    io: uploaded_file[:tempfile],
                    filename: uploaded_file[:filename],
                    content_type: uploaded_file[:type],
                  )
                  url = BASE_URL + Rails.application.routes.url_helpers.rails_blob_path(user.profile.image, only_path: true)

                  user.profile.update(image_url: url)

                  {message: MSG_SUCCESS, status: 200, result: 'Image Updated Successfully.', userImageUrl: user.profile.image_url}
                else
                  { message: MSG_SUCCESS, status: 200, result: 'Image Not Attached or Not Valid Image.' }
                end
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-Image-Upload-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        resources :accountSettings do
          desc "Api to add to favorites and watchlist"
          before{api_params}
  
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

                accountDetails = {
                  name: user.social_name,
                  mobileNumber: user.mobile_number,
                }

                if user.subscription_histories.present?
                  subscription = Subscription.find_by( id: (user.subscription_histories.last.subscription_id).to_i+1 )
                end

                if subscription
                  subscriptionDetails = {
                    id: subscription.id,name: subscription.name, duration: "For #{subscription.duration}", realAmount: "₹#{subscription.real_amount}", offerAmount: "₹#{subscription.offer_amount}", offer: "SAVE #{100-((subscription.offer_amount.to_f/subscription.real_amount.to_f)*100).ceil}%"
                  }
                else
                  subscription = Subscription.first
                  subscriptionDetails = {
                    id: subscription.id,name: subscription.name, duration: "For #{subscription.duration}", realAmount: "₹#{subscription.real_amount}", offerAmount: "₹#{subscription.offer_amount}", offer: "SAVE #{100-((subscription.offer_amount.to_f/subscription.real_amount.to_f)*100).ceil}%"
                  }
                end
                {message: MSG_SUCCESS, status: 200, accountDetails: accountDetails, subscriptionDetails: subscriptionDetails }
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-accountSettings-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end





        
  
        
        resources :myAccount do
          desc "Api to show data in my account list"
          before{api_params}
  
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

                accountDetails = {
                  userImageUrl: user.profile.image_url,
                  name: user.profile.name,
                  mobileNumber: user.mobile_number,
                }

                if user.subscription_histories.present?
                  subscription = user.subscription_histories.find_by(status: 'active')
                end

                if subscription
                  subscriptionDetails = {
                    name: subscription.subscription.name, subtitle: "Till #{subscription.subscription_end.to_date.strftime('%B %d, %Y')}"
                  }
                else
                  subscription = Subscription.first
                  subscriptionDetails = {
                    name: subscription.name, subtitle: "Only Rs-#{subscription.offer_amount} for #{subscription.duration}"
                  }
                end
                {message: MSG_SUCCESS, status: 200, primeUser: user.subscription_histories.exists?(status: 'active'),accountDetails: accountDetails, subscriptionDetails: subscriptionDetails}
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-myAccount-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end







        
  
        
        resources :planDetails do
          desc "Api to show existing plan detail."
          before{api_params}
  
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
                if user.subscription_histories.present?
                  subscription = user.subscription_histories.find_by(status: 'active')
                  history = []
                  if subscription
                    productDetails = {
                      name: subscription.subscription.name,
                      duration: "Valid Till #{subscription.subscription_end.to_date.strftime('%B %d, %Y')}",
                      amount: "₹ #{subscription.subscription.offer_amount} /-",
                    }

                    history << {
                      name: subscription.subscription.name,
                      duration: subscription.subscription.duration,
                      buyDate: subscription.created_at.to_date.strftime('%B %d, %Y'),
                      price: "₹ #{subscription.subscription.offer_amount} /-",
                      status: subscription.status,
                    }
                  end

                  
                  user.subscription_histories.where.not(status: ['active', 'expired']).each do |his|
                    history << {
                      name: his.subscription.name,
                      duration: his.subscription.duration,
                      buyDate: his.created_at.to_date,
                      price: "₹ #{his.subscription.offer_amount} /-",
                      status: "Start On #{his.subscription_start.to_date.strftime('%B %d, %Y')}"
                    }
                  end

                  user.subscription_histories.where.not("status LIKE ?", 'pending%').where.not(status: ['active', 'pending']).each do |his|
                    history << {
                      name: his.subscription.name,
                      duration: his.subscription.duration,
                      buyDate: his.created_at.to_date,
                      price: "₹ #{his.subscription.offer_amount} /-",
                      status: his.status,
                    }
                  end
                end

                {message: MSG_SUCCESS, status: 200, productDetails: productDetails,  history: history}
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-myAccount-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end






        resources :payment do
          desc "Api to add payement details and buy plans"
          before{api_params}
  
          params do 
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false

            requires :orderId, type: String, allow_blank: false
            requires :paymentId, type: String, allow_blank: false
            requires :subscriptionId, type: String, allow_blank: false
            requires :amount, type: String, allow_blank: false
            requires :couponId, type: String, allow_blank: false
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user

                present_plan = user.subscription_histories.find_by(status: 'active')

                if present_plan

                  valid_payment = user.payement_details.create(subscription_id: params[:subscriptionId], order_id: params[:orderId], payement_id: params[:paymentId], amount: params[:amount].to_f)

                  valid_subscription = Subscription.find_by(params[:subscriptionId])

                  if valid_subscription

                    duration = valid_subscription.duration.split(' ')
                    duration_number = duration[0].to_i
                    duration_unit = duration[1].singularize.downcase.to_sym

                    subscriptions = user.subscription_histories.where.not(status: ['expired', 'active'])
                    if subscriptions.count == 0
                        user.subscription_histories.create(
                        subscription_id: valid_subscription.id, 
                        subscription_start: DateTime.now.to_time, 
                        subscription_end: DateTime.now.to_time + duration_number.send(duration_unit),
                        coupon_id: params[:couponId], 
                        status: 'pending-1',
                        payement_detail_id: valid_payment.id 
                      )
                    else
                      user.subscription_histories.create(
                        subscription_id: valid_subscription.id, 
                        subscription_start: subscriptions.last.subscription_end, 
                        subscription_end: subscriptions.last.subscription_end.to_time + duration_number.send(duration_unit),
                        coupon_id: params[:couponId], 
                        status: "pending-#{subscriptions.count+1}", 
                        payement_detail_id: valid_payment.id 
                      )
                    end
                    {message: MSG_SUCCESS, status: 200, result: 'payement Recceived, Plan is in Queue'}
                  else
                    { message: MSG_SUCCESS, status: 200, result: 'InValid Subscription or Invalid Amount' } 
                  end


                else

                  valid_payement = user.payement_details.create(subscription_id: params[:subscriptionId], order_id: params[:orderId], payement_id: params[:paymentId], amount: params[:amount].to_f)

                  valid_subscription = Subscription.find_by(params[:subscriptionId])

                  if valid_subscription

                    duration = valid_subscription.duration.split(' ')
                    duration_number = duration[0].to_i
                    duration_unit = duration[1].singularize.downcase.to_sym

                    user.subscription_histories.create(
                      subscription_id: valid_subscription.id, 
                      subscription_start: DateTime.now.to_time, 
                      subscription_end: DateTime.now.to_time + duration_number.send(duration_unit), 
                      coupon_id: params[:couponId], 
                      status: 'active', 
                      payement_detail_id: valid_payement.id 
                    )

                    {message: MSG_SUCCESS, status: 200, result: 'payement recceived, plan activated'} 
                  else
                    { message: MSG_SUCCESS, status: 200, result: 'InValid Subscription or Invalid Amount' } 
                  end

                end

              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-accountSettings-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        resources :takeHelp do
          desc "Take Help in API"
          before{api_params}
          
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

                helpDesk = []
                HelpDesk.all.each do |help|
                  helpDesk << {
                    question: help.question,
                    answer: help.answer,
                    url: help.url,
                  }
                end

                { message: MSG_SUCCESS, status: 200, helpDesk: helpDesk }
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        
  
        
        resources :addWatchlist do
          desc "Add to WatchList API"
          before{api_params}
          
          params do 
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false

            requires :episodeId, type: String, allow_blank: false
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user
                episode = Episode.find_by(id: params[:episodeId])
                if episode
                  already_in_watchlist = user.watchlists.find_by(episode: episode)
                  if already_in_watchlist
                    already_in_watchlist.destroy
                    {message: MSG_SUCCESS, status: 200, added: false}
                  else
                    user.watchlists.create(episode: episode)
                    {message: MSG_SUCCESS, status: 200, added: true}
                  end
                else
                  {message: MSG_SUCCESS, status: 200, result: "Invalid Episode Id"}
                end
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end






        resources :addFavourite do
          desc "Add to Favourite List API"
          before{api_params}

          params do 
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false

            requires :episodeId, type: String, allow_blank: false
          end
  
          post do 
            begin
              user = valid_user(params['userId'].to_i, params['securityToken'])  
              if user
                episode = Episode.find_by(id: params[:episodeId])
                if episode
                  already_in_favourite = user.favorite_lists.find_by(episode: episode)
                  if already_in_favourite
                    already_in_favourite.destroy
                    {message: MSG_SUCCESS, status: 200, added: false}
                  else
                    user.favorite_lists.create(episode: episode)
                    {message: MSG_SUCCESS, status: 200, added: true}
                  end
                else
                  { message: MSG_SUCCESS, status: 200, result: "Invalid Episode Id" }
                end
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        
        
  
        
        resources :watchlist do
          desc "Show list WatchList API"
          before{api_params}
          
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
                watchlist = []
                user.watchlists.order(created_at: :desc).each do | episode_list |
                  watchlist << {
                    episodeId: episode_list.episode.id,
                    contentId: episode_list.episode.content_id,
                    thumbnail: episode_list.episode.thumbnail,
                    runtime: episode_list.episode.runtime,
                    episodeTitle: episode_list.episode.title,
                    contentName: episode_list.episode.content.title,
                  }
                end
                {message: MSG_SUCCESS, status: 200, watchlist: watchlist}
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        
        
  
        
        resources :favouriteList do
          desc "Show list Favourite list API"
          before{api_params}
          
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
                favorite_list = []
                user.favorite_lists.order(created_at: :desc).each do | episode_list |
                  favorite_list << {
                    episodeId: episode_list.episode.id,
                    contentId: episode_list.episode.content_id,
                    thumbnail: episode_list.episode.thumbnail,
                    runtime: episode_list.episode.runtime,
                    episodeTitle: episode_list.episode.title,
                    contentName: episode_list.episode.content.title,
                  }
                end
                {message: MSG_SUCCESS, status: 200, favoriteList: favorite_list}
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end
        
  
        
        resources :invite do
          desc "Take Help in API"
          before{api_params}

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
                referLink = "#{BASE_URL}/invite/#{user.referral_code}"
                imageLink = "https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI"

                inviteText = "\u003ch3\u003e1. Refer \u0026 Earn Program:\u003c/h3\u003e \u003ch3\u003eलाभ:\u003c/h3\u003e\u003cp\u003eआपको प्रत्येक रेफरल के वार्षिक सब्सक्रिप्शन पर ₹100 का कमीशन मिलेगा। और रिन्यूअल पर  5 % कमीशन लाइफटाइम मिलेगा।\u003c/p\u003e\u003ch3\u003eअन्य लाभ:\u003c/h3\u003e\u003cp\u003e•3 रेफरल के मासिक सब्सक्रिप्शन (₹79) पर आपका 30 दिन का सब्सक्रिप्शन फ्री।\u003cbr\u003e•10 रेफ़रल के त्रैमासिक सब्सक्रिप्शन  (₹179)  पर आपका 90 दिन का सब्सक्रिप्शन फ्री।\u003cbr\u003e•10 रेफ़रल (लोगों) के वार्षिक सब्सक्रिप्शन पर आपका वार्षिक सब्सक्रिप्शन फ्री।\u003c/p\u003e\u003cbr\u003e\u003ch3\u003e नियम व शर्तें:\u003cbr\u003eइन रेफरल नियमों और शर्तों को संयुक्त रूप से और 'उपयोग की शर्तों' में निर्धारित नियमों और शर्तों के अतिरिक्त पढ़ा जाएगा\u003c/h3\u003e\u003cbr\u003e\u003cp\u003e1.अपने दोस्तों को  रेफरल लिंक  या कोड से अम्बेसिने ऐप में जोड़ें, और अम्बेसिने ऐप का सब्सक्रिप्शन करने में मदद करें ।\u003cbr\u003e2. कमीशन सीधे आपके बैंक अकाउंट में हर सोमवार को प्राप्त होगा।\u003cbr\u003e3. लाभार्थी होने पर आपके बैंक अकाउंट की जानकारी के लिए आपको पंजीकृत ईमेल या मोबाइल नंबर पर पूछा जायेगा।\u003cbr\u003e4. यह योजना सिर्फ वार्षिक सब्सक्रिप्शन पर ही मान्य है।  \u003cbr\u003e5. किसी भी प्रकार के विवाद की स्थिति में प्रबंधन का निर्णय अंतिम और बाध्यकारी होगा। ‘अम्बेसिने’ बिना कोई कारण बताए या आपको बिना किसी पूर्व सूचना के रेफरल प्रोग्राम में बदलाव या बंद करने का अधिकार सुरक्षित रखता है।\u003c/p\u003e \u003cbr\u003e\u003ch3\u003eCall/WhatsApp Support: 9520984545\u003cbr\u003e2. Mobile Partner:\u003cbr\u003eHelp people to take the subscription by top up/recharge their AmbeCine Account and get a flat 5% commission on the transaction amount.\u003cbr\u003eTerms:\u003c/h3\u003e Share the transaction proof/record on WhatsApp/Email (9520984545)\u003cbr\u003eMinimum 10 transaction required to get the payout.\u003cbr\u003eP"

                 steps = "\u003ch3\u003e1. Refer \u0026 Earn Program:\u003c/h3\u003e \u003ch3\u003eलाभ:\u003c/h3\u003e\u003cp\u003eआपको प्रत्येक रेफरल के वार्षिक सब्सक्रिप्शन पर ₹100 का कमीशन मिलेगा। और रिन्यूअल पर  5 % कमीशन लाइफटाइम मिलेगा।\u003c/p\u003e\u003ch3\u003eअन्य लाभ:\u003c/h3\u003e\u003cp\u003e•3 रेफरल के मासिक सब्सक्रिप्शन (₹79) पर आपका 30 दिन का सब्सक्रिप्शन फ्री।\u003cbr\u003e•10 रेफ़रल के त्रैमासिक सब्सक्रिप्शन  (₹179)  पर आपका 90 दिन का सब्सक्रिप्शन फ्री।\u003cbr\u003e•10 रेफ़रल (लोगों) के वार्षिक सब्सक्रिप्शन पर आपका वार्षिक सब्सक्रिप्शन फ्री।\u003c/p\u003e\u003cbr\u003e\u003ch3\u003e नियम व शर्तें:\u003cbr\u003eइन रेफरल नियमों और शर्तों को संयुक्त रूप से और 'उपयोग की शर्तों' में निर्धारित नियमों और शर्तों के अतिरिक्त पढ़ा जाएगा\u003c/h3\u003e\u003cbr\u003e\u003cp\u003e1.अपने दोस्तों को  रेफरल लिंक  या कोड से अम्बेसिने ऐप में जोड़ें, और अम्बेसिने ऐप का सब्सक्रिप्शन करने में मदद करें ।\u003cbr\u003e2. कमीशन सीधे आपके बैंक अकाउंट में हर सोमवार को प्राप्त होगा।\u003cbr\u003e3. लाभार्थी होने पर आपके बैंक अकाउंट की जानकारी के लिए आपको पंजीकृत ईमेल या मोबाइल नंबर पर पूछा जायेगा।\u003cbr\u003e4. यह योजना सिर्फ वार्षिक सब्सक्रिप्शन पर ही मान्य है।  \u003cbr\u003e5. किसी भी प्रकार के विवाद की स्थिति में प्रबंधन का निर्णय अंतिम और बाध्यकारी होगा। ‘अम्बेसिने’ बिना कोई कारण बताए या आपको बिना किसी पूर्व सूचना के रेफरल प्रोग्राम में बदलाव या बंद करने का अधिकार सुरक्षित रखता है।\u003c/p\u003e \u003cbr\u003e\u003ch3\u003eCall/WhatsApp Support: 9520984545\u003cbr\u003e2. Mobile Partner:\u003cbr\u003eHelp people to take the subscription by top up/recharge their AmbeCine Account and get a flat 5% commission on the transaction amount.\u003cbr\u003eTerms:\u003c/h3\u003e Share the transaction proof/record on WhatsApp/Email (9520984545)\u003cbr\u003eMinimum 10 transaction required to get the payout.\u003cbr\u003eP"

                { message: MSG_SUCCESS, status: 200, imageLink: imageLink, referLink: referLink, inviteText: inviteText, steps: steps}
              else
                {message: INVALID_USER, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-helpDesk-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end


        
      end
    end
  end