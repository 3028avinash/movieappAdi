module MovieApp
  module V1
    class Appdetails < Grape::API
    include MovieApp::V1::Defaults

      # FREE_SHOWS(1),
      # VIP_SHOWS(2),
      # COMING_SOON(3),
      # GENRE(4),
      # TOP_10(5),
      # TRENDING(6),
      # SPECIAL_FOR_YOU(7),
      # POPULAR_ARTIST(8),
      # ALL_NEW_SHOWS(9)

      resource :homePage do
        desc "List on Home API"
        before {api_params}
        params do
          requires :userId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
        end
        post do
          begin
            user = valid_user(params['userId'], params['securityToken'])
            if user
              # arr=["https://collider.com/wp-content/uploads/the-avengers-movie-poster-banners-04.jpg","https://collider.com/wp-content/uploads/inception_movie_poster_banner_04.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1p8kum07YBbQk23t-dkxEENhe9Zl2dMVfA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5ABHGqdatd7u5-OQ6LqQ3mnTf4V2fG1F8WQ&usqp=CAU","https://www.yashrajfilms.com/images/default-source/gallery/pathaan-banner.jpg?sfvrsn=14dbdfcc_0","https://lumiere-a.akamaihd.net/v1/images/20cs_xmen_dark_phoenix_hero_banner_b26f8933.jpeg?region=0,0,1800,776&width=960"] 
              # showHash1={}
              # showHash2={}
              # showList << {category: "Banner",bannerList: bannerHash} 
            
              bannerImage = Content.where(is_slider: true)
              
              bannerHash=[]
              bannerImage.each_with_index do | item, index |
                bannerHash[index] = {id: item.id, banner: item.banner}
              end

              shows = Content.where("genre LIKE ? and vip_status like ?" , "%drama%", true).order("RANDOM()") #false

              contentList=[]
              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end

              showList=[] 
              showList << {category: "Free Shows", type: 1, contentList: contentList}

              shows= Content.where("genre LIKE ? and vip_status like ?" , "%action%", true).order("RANDOM()") #false 

              contentList=[]
              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Newly Added", type: 9, contentList: contentList}
              
              contentList=[]
              shows= Content.where("genre LIKE ? and vip_status like ?" , "%crime%", true).order("RANDOM()") #false 

              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Special For You", type: 7, contentList: contentList}

              shows= Content.where("genre LIKE ? and vip_status like ?" , "%thriller%", true).order("RANDOM()") #false 

              contentList=[]
              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Trending", type: 6, contentList: contentList}

              {message: MSG_SUCCESS, status: 200, bannerHash: bannerHash, showList: showList}

            else
              {message: INVALID_USER, status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-homePage-#{params.inspect}-Error-#{e}"
            {message: MSG_ERROR, status: 500}
          end
        end
      end

      resource :vipList do
        desc "Vip List on Home API"
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
              showList=[]

              contentList=[]
              shows= Content.where("genre like ? and vip_status like ?" , "%drama%", true).limit(6).order("RANDOM()")
              shows.each_with_index do |item,index|
                contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Drama", contentList: contentList}

              contentList=[]
              shows= Content.where("genre like ? and vip_status like ?" , "%action%", true).limit(6).order("RANDOM()")
              shows.each_with_index do |item,index|
                contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Action", contentList: contentList}

              contentList=[]
              shows= Content.where("genre like ? and vip_status like ?" , "%thriller%", true).limit(6).order("RANDOM()")
              shows.each_with_index do |item,index|
                contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Thriller", contentList: contentList}

              contentList=[]
              shows= Content.where("genre like ? and vip_status like ?" , "%crime%", true).limit(6).order("RANDOM()")
              shows.each_with_index do |item,index|
                contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Crime", contentList: contentList}

              {message: MSG_SUCCESS, status: 200, showList: showList}
            else
              {message: INVALID_USER, status: 500}
            end
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-homePage-#{params.inspect}-Error-#{e}"
            {message: MSG_ERROR, status: 500}
          end
        end
      end

      resource :upcomingList do
        desc "Upcoming List on Home API"
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
                    # arr=["https://collider.com/wp-content/uploads/the-avengers-movie-poster-banners-04.jpg","https://collider.com/wp-content/uploads/inception_movie_poster_banner_04.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1p8kum07YBbQk23t-dkxEENhe9Zl2dMVfA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5ABHGqdatd7u5-OQ6LqQ3mnTf4V2fG1F8WQ&usqp=CAU","https://www.yashrajfilms.com/images/default-source/gallery/pathaan-banner.jpg?sfvrsn=14dbdfcc_0","https://lumiere-a.akamaihd.net/v1/images/20cs_xmen_dark_phoenix_hero_banner_b26f8933.jpeg?region=0,0,1800,776&width=960"]

                    showList=[]
                    shows= Content.where("release_date > ?" , Time.now.year)
                    # rStatus.present ? rstatus : false 
                    shows.each do |item|
                      rStatus = Reminder.find_by("user_id = ? and content_id = ?", params[:userId], item.id)
                      showHash = {id: item.id, banner: item.banner, name: item.title, director: Episode.where(content_id: item.id).present? ? Episode.where(content_id: item.id).first.director : "XYZ", reminderStatus: rStatus.present? ? rStatus.status : false}
                      showList << showHash
                    end
                    {message: MSG_SUCCESS, status: 200, showList: showList }
                  else
                    {message: INVALID_USER, status: 500}
                  end  
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-upcomingList-#{params.inspect}-Error-#{e}"
                {message: MSG_ERROR, status: 500}
              end
          end
      end

      resource :reminderUpdate do
        desc "Upcoming List on Home API"
        before {api_params}
        params do
          requires :userId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
          requires :contentId, type: String, allow_blank: false
        end
        post do
          begin
              # user = valid_user(params['userId'].to_i, params['securityToken'])
            if true
              p=Reminder.find_by("user_id = ? and content_id = ?",params[:userId],params[:contentId])
            if p.present? 
              if p.status
                p.update(status: false)
              else
                p.update(status: true)
              end
            else
              p=Reminder.create(user_id: params[:userId], content_id: params[:contentId], status: true)
            end
              {message: MSG_SUCCESS, status: 200 , reminderStatus: p.status}
            else
              {message: INVALID_USER, status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-upcomingList-#{params.inspect}-Error-#{e}"
            {message: MSG_ERROR, status: 500}
          end
        end
      end

      resource :subscriptionList do
        desc "Subscription List on Home API"
        before {api_params}
        params do
          requires :userId, type: String, allow_blank: false
          requires :securityToken, type: String, allow_blank: false
          requires :versionName, type: String, allow_blank: false
          requires :versionCode, type: String, allow_blank: false
        end
        post do
          begin
            # user = valid_user(params['userId'].to_i, params['securityToken'])
            if true
              subscriptionList=[]
              couponList=[]
              l=Subscription.order(created_at: :desc)
              l.each_with_index do |element,index|
                subscriptionList[index]={id: element.id,name: element.name, duration: "For #{element.duration}", realAmount: "₹#{element.real_amount}", offerAmount: "₹#{element.offer_amount}", offer: "SAVE #{100-((element.offer_amount.to_f/element.real_amount.to_f)*100).ceil}%"}
              end
              c=Coupon.where(status: true)
              c.each do |item|
                couponHash = {id: item.id, code: item.code, offer: item.offer }
                couponList << couponHash
              end
              {
                message: MSG_SUCCESS, 
                status: 200, 
                subscriptionList: subscriptionList,
                couponList: couponList,
                features: 
                  [
                    {
                        url: "https://png.pngtree.com/element_our/sm/20180516/sm_5afbfa0103191.jpg",
                        text: "Watch VIP Shows & Movies"
                    },
                    {
                        url: "https://png.pngtree.com/element_our/sm/20180516/sm_5afbfa0103191.jpg",
                        text: "Watch all shows on tv"
                    },
                    {
                        url: "https://png.pngtree.com/element_our/sm/20180516/sm_5afbfa0103191.jpg",
                        text: "Watch shows in high quality"
                    }
                  ]
              }
            else
              {message: INVALID_USER, status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
            {message: MSG_ERROR, status: 500}
          end
        end
      end

      resource :accountList do
          desc "Subscription List on Home API"
          before {api_params}
          params do
            requires :userId, type: String, allow_blank: false
            requires :securityToken, type: String, allow_blank: false
            requires :versionName, type: String, allow_blank: false
            requires :versionCode, type: String, allow_blank: false
          end
          post do
            begin
              # user = valid_user(params['userId'].to_i, params['securityToken'])
              # user=User.find_by_id(params[:userId])
              if true
                sub=SubscriptionHistory.where(user_id: user.id).last
                s=Subscription.find_by_id(sub.id)
                subscriptionList = {name: s.name, start: sub.subscription_start, end: sub.subscription_end , price: s.offer_amount}
                {
                  message: MSG_SUCCESS, 
                  status: 200, 
                  name: user.social_name,
                  number: user.mobile_number,
                  subscriptionList: subscriptionList
                }
              else
                {message: INVALID_USER, status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
      end

      resource :languageList do
          desc "Subscription List on Home API"
          before {api_params}
          params do
            # requires :userId, type: String, allow_blank: false
            # requires :securityToken, type: String, allow_blank: false
            # requires :versionName, type: String, allow_blank: false
            # requires :versionCode, type: String, allow_blank: false
          end
          post do
            begin
              # user = valid_user(params['userId'].to_i, params['securityToken'])
              # user=User.find_by_id(params[:userId])
              if true
                languages = Content.distinct.pluck(:language)
                {
                  message: MSG_SUCCESS, 
                  status: 200, 
                  languages: languages
                }
              else
                {message: INVALID_USER, status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
      end

      resource :languageUpdate do
          desc "Subscription List on Home API"
          before {api_params}
          params do
            requires :userId, type: String, allow_blank: false
            # requires :securityToken, type: String, allow_blank: false
            # requires :versionName, type: String, allow_blank: false
            # requires :versionCode, type: String, allow_blank: false
            requires :language, type: String, allow_blank: false
          end
          post do
            begin
              # user = valid_user(params['userId'].to_i, params['securityToken'])
              user=User.find_by_id(params[:userId])
              if true
                user.update(content_language: language)
                {
                  message: MSG_SUCCESS, 
                  status: 200, 
                }
              else
                {message: INVALID_USER, status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
      end

      # resource :detailPage do
      #     desc "Match List on Home API"
      #     before {api_params}
      #     params do
      #       # requires :userId, type: String, allow_blank: false
      #       # requires :securityToken, type: String, allow_blank: false
      #       # requires :versionName, type: String, allow_blank: false
      #       # requires :versionCode, type: String, allow_blank: false
      #       requires :contentId, type: String, allow_blank: false
      #     end
      #     post do
      #       begin
      #         # user = valid_user(params['userId'].to_i, params['securityToken'])
      #         if true
      #           episodeList=[]
      #           contentList=[]
      #           l=Content.find_by_id(params[:contentId].to_i)
      #           l.episodes.each do |element|
      #             episodeHash={id: element.id,title: element.thumbnail}
      #             episodeList << episodeHash
      #           end
      #           c=Content.order(views: :desc).limit(10)
      #         #   order("RANDOM(1,3)").limit(10)
      #           c.each do |item|
      #             contentHash = {id: item.id, banner: item.banner}
      #             contentList << contentHash
      #           end
      #           {
      #             message: MSG_SUCCESS, 
      #             status: 200, 
      #             url: l.episodes.first.url,
      #             episodeList: episodeList,
      #             contentList: contentList
      #           }
      #         else
      #           {message: INVALID_USER, status: 500}
      #         end  
      #       rescue Exception => e
      #         logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
      #         {message: MSG_ERROR, status: 500}
      #       end
      #     end
      # end

      resource :detailPage do
            desc "Detail Page on Home API"
            before {api_params}
            params do
              requires :userId, type: String, allow_blank: false
              requires :securityToken, type: String, allow_blank: false
              requires :versionName, type: String, allow_blank: false
              requires :versionCode, type: String, allow_blank: false
              requires :isEpisode, type: String, allow_blank: false
              requires :contentId, type: String, allow_blank: false
              optional :episodeId, type: String, allow_blank: false
            end
    
            post do
              begin
                user = valid_user(params['userId'].to_i, params['securityToken'])
                if user
                  if params[:contentId].present?
                    cast=[]
                    # director=[]
                    episode=[]
                    recommendation=[]
                    l=Content.find_by_id(params[:contentId].to_i)
                    count=l.views.to_i+1
                    l.update(views: count)
                    if params[:episodeId].present?
                      episodeData=l.episodes.find_by(id: params[:episodeId])
                    else
                      episodeData=l.episodes.first
                    end
                    episodeList=l.episodes
                    episodeList.each do |element|
                      played_before = PlayTime.find_by(episode: element, user: user)
                      episodeHash={id: element.id, name: element.title, thumbnail: element.thumbnail, runtime: element.runtime, genre: l.genre, vipStatus: element.vip_status, lastTime: played_before.present? ? played_before.time : nil }
                      episode << episodeHash
                    end
                    recommendationList=Content.order(views: :desc)
                    recommendationList.each do |element|
                      recommendationHash={id: element.id, thumbnail: element.banner, vipStatus: element.vip_status.present? }
                      recommendation << recommendationHash
                    end
                    # his=History.find_by("user_id LIKE ? and episode_id LIKE ?", user.id, episodeData.id)
                    watchlist = user.watchlists.find_by(episode_id: episodeData.id)
                    favoritelist = user.favorite_lists.find_by(episode_id: episodeData.id)

                    detailsList = {isFav: favoritelist.present? ? true : false, isWl: watchlist.present? ? true : false, title: l.title, season: "#{episodeData.season}" ,episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: l.genre, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: episodeData.cast, directors: episodeData.director}
                    {
                      message: MSG_SUCCESS,
                      status: 200, 
                      primeUser: user.subscription_histories.exists?(status: 'active'),   #hardcoded for now, will be changed in schema later
                      videoDetails: detailsList,
                      episodeList: episode,
                      recommendationList: recommendation
                    }
                  else
                    episodeData=Episode.find_by_id(params[:episodeId].to_i)

                    l=episodeData.content
                    played_before = PlayTime.find_by(episode: episodeData, user: user)

                    count=l.views.to_i+1

                    l.update(views: count)

                    his=History.find_by("user_id LIKE ? and episode_id LIKE ?", user.id, episodeData.id)
                    watchlist = user.watchlists.find_by(episode_id: episodeData.id)
                    favoritelist = user.favorite_lists.find_by(episode_id: episodeData.id)

                    detailsList = {isFav: favoritelist.present? ? true : false, isWl: watchlist.present? ? true : false, title: l.title,season: "#{episodeData.season}", episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: l.genre, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: episodeData.cast, directors: episodeData.director, lastTime: played_before.present? ? played_before.time : nil   }

                    { message: MSG_SUCCESS, status: 200, primeUser: user.subscription_histories.exists?(status: 'active'), videoDetails: detailsList }
                  end
                else
                  {message: INVALID_USER, status: 500}
                end  
    
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-detailPage-#{params.inspect}-Error-#{e}"
                {message: MSG_ERROR, status: 500}
              end
            end
          end
        

          resources :addHistory do

            desc "Api to add to favorites and watchlist"
            before{api_params}
    
            params do 
              requires :userId, type: String, allow_blank: false
              requires :securityToken, type: String, allow_blank: false
              requires :versionName, type: String, allow_blank: false
              requires :versionCode, type: String, allow_blank: false
              requires :actionType, type: String, allow_blank: false
              requires :episodeId, type: String, allow_blank:false
            end
    
            post do 
              begin
                user = valid_user(params['userId'].to_i, params['securityToken'])
                if params[:episodeId] == "null" 
                  params[:episodeId]="1"
                end
                if user
                  wList=false
                  fList=false
                  hislist = History.find_by("user_id LIKE ? and episode_id LIKE ?", user.id, params[:episodeId].to_i)
                  if hislist.present?
                    if params[:actionType] == "1"   #1 - watchList
                      wlist = hislist.watch_list ? hislist.update(watch_list: false) : hislist.update(watch_list: true)
                    elsif params[:actionType] == "2"
                      flist = hislist.favorite_list ? hislist.update(favorite_list: false) : hislist.update(favorite_list: true)
                    end
                  else
                    if params[:actionType] == "1"
                      wList=true
                      History.create(user_id: user.id,episode_id: params[:episodeId],watch_list: wList,favorite_list: false)
                    elsif params[:actionType] == "2"
                      fList=true
                      History.create(user_id: user.id,episode_id: params[:episodeId],favorite_list: fList,watch_list: false)
                    end
                  end
                
                  {message: MSG_SUCCESS, status: 200, watchlisted: wList, favorited: fList}
                else
                    {message: INVALID_USER, status: 500}
                end
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-addHistory-#{params.inspect}-Error-#{e}"
                {message: MSG_ERROR, status: 500}
              end
            end
          end
        


          resources :updatePlayTime do
            desc "Api to add to favorites and watchlist"
            before{api_params}
            params do 
              requires :userId, type: String, allow_blank: false
              requires :securityToken, type: String, allow_blank: false
              requires :versionName, type: String, allow_blank: false
              requires :versionCode, type: String, allow_blank: false
              requires :episodeId, type: String, allow_blank:false
              requires :time, type: String, allow_blank:false
            end

            post do 
              begin
                user = valid_user(params['userId'].to_i, params['securityToken'])
                if user
                  episode = Episode.find_by_id(params[:episodeId].to_i)
                  if episode
                    play_time = PlayTime.find_or_initialize_by(user: user, episode: episode)
                    if play_time.persisted?
                      play_time.update(time: params[:time])
                    else
                      play_time.assign_attributes(time: params[:time])
                      play_time.save
                    end
                    {message: MSG_SUCCESS, status: 200, data: 'Updated Successfully.'}
                  else
                    {message: MSG_SUCCESS, status: 200, data: 'Not Valid Episode'}
                  end
                else
                  {message: INVALID_USER, status: 500}
                end
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-addHistory-#{params.inspect}-Error-#{e}"
                {message: MSG_ERROR, status: 500}
              end
            end
          end




          resources :exploreContent do
            desc "Api to add to favorites and watchlist"
            before{api_params}
            params do 
              requires :userId, type: String, allow_blank: false
              requires :securityToken, type: String, allow_blank: false
              requires :versionName, type: String, allow_blank: false
              requires :versionCode, type: String, allow_blank:false
              requires :genre, type: String, allow_blank:false
            end

            post do 
              begin
                user = valid_user(params['userId'].to_i, params['securityToken'])
                if user
                  content_data = []
                  Content.where('LOWER(genre) LIKE ?', "%#{params[:genre].to_s.strip.downcase}%").each do |content|
                      content_data << {
                      contentId: content.id,
                      isVip: content.vip_status,
                      thumbnail: content.banner,
                    }
                  end
                  {message: MSG_SUCCESS, status: 200, result: content_data}
                else
                  {message: INVALID_USER, status: 500}
                end
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-addHistory-#{params.inspect}-Error-#{e}"
                {message: MSG_ERROR, status: 500}
              end
            end
          end



        resource :getText do
          desc "Api to add to favorites and watchlist"
            before{api_params}
            params do 
              requires :userId, type: String, allow_blank: false
              requires :securityToken, type: String, allow_blank: false
              requires :versionName, type: String, allow_blank: false
              requires :versionCode, type: String, allow_blank: false
              requires :genre, type: String, allow_blank:false
            end
          post do
            user = valid_user(params[:userId], params[:securityToken])
            if user
            else
            end

          end
        end
        





        # resource :getText do
        #   desc "Example Cipher Text"
        #   post do
        #     # key = OpenSSL::Random.random_bytes(32)
        #     # key = SecureRandom.hex(16)
        #     encrypted_data = encrypt_string("Mubarak Ho...", '3f5225f85d1ea15eeada28badcc03a06')
        #     # encrypted_data = new_cipher("Mubarak Ho...", '3f5225f85d1ea15eeada28badcc03a06')
        #     decrypted_data = decrypt_string(encrypted_data, "3f5225f85d1ea15eeada28badcc03a06")
        #     {data: decrypted_data, key: '3f5225f85d1ea15eeada28badcc03a06'}
        #   end
        # end
        






    end
  end
end