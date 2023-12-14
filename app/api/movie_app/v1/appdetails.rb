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
        # params do
        # requires :userId, type: String, allow_blank: false
        # requires :securityToken, type: String, allow_blank: false
        # requires :versionName, type: String, allow_blank: false
        # requires :versionCode, type: String, allow_blank: false
        # end
        post do
          begin
              # user = valid_user(params['userId'].to_i, params['securityToken'])
            if true
            # arr=["https://collider.com/wp-content/uploads/the-avengers-movie-poster-banners-04.jpg","https://collider.com/wp-content/uploads/inception_movie_poster_banner_04.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1p8kum07YBbQk23t-dkxEENhe9Zl2dMVfA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5ABHGqdatd7u5-OQ6LqQ3mnTf4V2fG1F8WQ&usqp=CAU","https://www.yashrajfilms.com/images/default-source/gallery/pathaan-banner.jpg?sfvrsn=14dbdfcc_0","https://lumiere-a.akamaihd.net/v1/images/20cs_xmen_dark_phoenix_hero_banner_b26f8933.jpeg?region=0,0,1800,776&width=960"] 
              bannerImage = Content.where(is_slider: true)
              bannerHash=[]
              # showHash1={}
              # showHash2={}
            
              showList=[]
              bannerImage.each_with_index do |item,index|
                bannerHash[index] = {id: item.id, banner: item.banner}
              end
              # showList << {category: "Banner",bannerList: bannerHash} 
              contentList=[]
              shows= Content.where("genre LIKE ? and vip_status like ?" , "%drama%", true).order("RANDOM()") #false
              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Free Shows", type: 1, contentList: contentList}

              contentList=[]
              shows= Content.where("genre LIKE ? and vip_status like ?" , "%action%", true).order("RANDOM()") #false 
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

              contentList=[]
              shows= Content.where("genre LIKE ? and vip_status like ?" , "%thriller%", true).order("RANDOM()") #false 
              shows.each_with_index do |item,index|
                  contentList[index] = {id: item.id, thumbnail: item.banner}
              end
              showList << {category: "Trending", type: 6, contentList: contentList}
              {message: "MSG_SUCCESS", status: 200,bannerHash: bannerHash, showList: showList}
            else
              {message: "INVALID_USER", status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-homePage-#{params.inspect}-Error-#{e}"
            {message: "MSG_ERROR", status: 500}
          end
        end
      end

      resource :vipList do
          desc "Vip List on Home API"
          before {api_params}
          # params do
          # requires :userId, type: String, allow_blank: false
          # requires :securityToken, type: String, allow_blank: false
          # requires :versionName, type: String, allow_blank: false
          # requires :versionCode, type: String, allow_blank: false
          # end
          post do
              begin
                  # user = valid_user(params['userId'].to_i, params['securityToken'])
                  if true
                  # arr=["https://collider.com/wp-content/uploads/the-avengers-movie-poster-banners-04.jpg","https://collider.com/wp-content/uploads/inception_movie_poster_banner_04.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1p8kum07YBbQk23t-dkxEENhe9Zl2dMVfA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5ABHGqdatd7u5-OQ6LqQ3mnTf4V2fG1F8WQ&usqp=CAU","https://www.yashrajfilms.com/images/default-source/gallery/pathaan-banner.jpg?sfvrsn=14dbdfcc_0","https://lumiere-a.akamaihd.net/v1/images/20cs_xmen_dark_phoenix_hero_banner_b26f8933.jpeg?region=0,0,1800,776&width=960"] 
                      contentList=[]
                      showList=[]
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

                  {message: "MSG_SUCCESS", status: 200, showList: showList}
                  else
                  {message: "INVALID_USER", status: 500}
                  end   
              rescue Exception => e
                  logger.info "API Exception-#{Time.now}-homePage-#{params.inspect}-Error-#{e}"
                  {message: "MSG_ERROR", status: 500}
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
                      rStatus = Reminder.find_by("user_id = ? and content_id = ?", params[:userId], item.id).status
                      shows.each do |item|
                          showHash = {id: item.id, banner: item.banner, name: item.title, director: Episode.where(content_id: item.id).first.director, reminderStatus:  rStatus.present ? rstatus : false }
                          showList << showHash
                      end
                      
                  {message: "MSG_SUCCESS", status: 200, showList: showList }
                  else
                  {message: "INVALID_USER", status: 500}
                  end  
              rescue Exception => e
                  logger.info "API Exception-#{Time.now}-upcomingList-#{params.inspect}-Error-#{e}"
                  {message: "MSG_ERROR", status: 500}
              end
          end
      end

      resource :reminderUpdate do
        desc "Upcoming List on Home API"
        before {api_params}
        params do
          requires :userId, type: String, allow_blank: false
          # requires :securityToken, type: String, allow_blank: false
          # requires :versionName, type: String, allow_blank: false
          # requires :versionCode, type: String, allow_blank: false
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
              {message: "MSG_SUCCESS", status: 200 , reminderStatus: p.status}
            else
              {message: "INVALID_USER", status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-upcomingList-#{params.inspect}-Error-#{e}"
            {message: "MSG_ERROR", status: 500}
          end
        end
      end

      resource :subscriptionList do
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
                message: "MSG_SUCCESS", 
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
              {message: "INVALID_USER", status: 500}
            end  
          rescue Exception => e
            logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
            {message: "MSG_ERROR", status: 500}
          end
        end
      end

      resource :accountList do
          desc "Subscription List on Home API"
          before {api_params}
          params do
            requires :userId, type: String, allow_blank: false
            # requires :securityToken, type: String, allow_blank: false
            # requires :versionName, type: String, allow_blank: false
            # requires :versionCode, type: String, allow_blank: false
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
                  message: "MSG_SUCCESS", 
                  status: 200, 
                  name: user.social_name,
                  number: user.mobile_number,
                  subscriptionList: subscriptionList
                }
              else
                {message: "INVALID_USER", status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: "MSG_ERROR", status: 500}
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
                  message: "MSG_SUCCESS", 
                  status: 200, 
                  languages: languages
                }
              else
                {message: "INVALID_USER", status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: "MSG_ERROR", status: 500}
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
                  message: "MSG_SUCCESS", 
                  status: 200, 
                }
              else
                {message: "INVALID_USER", status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
              {message: "MSG_ERROR", status: 500}
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
      #             message: "MSG_SUCCESS", 
      #             status: 200, 
      #             url: l.episodes.first.url,
      #             episodeList: episodeList,
      #             contentList: contentList
      #           }
      #         else
      #           {message: "INVALID_USER", status: 500}
      #         end  
      #       rescue Exception => e
      #         logger.info "API Exception-#{Time.now}-subscriptionList-#{params.inspect}-Error-#{e}"
      #         {message: "MSG_ERROR", status: 500}
      #       end
      #     end
      # end

      resource :detailPage do
            desc "Detail Page on Home API"
            before {api_params}
            params do
              requires :userId, type: String, allow_blank: false
              # requires :securityToken, type: String, allow_blank: false
              # requires :versionName, type: String, allow_blank: false
              # requires :versionCode, type: String, allow_blank: false
              # requires :isEpisode, type: String, allow_blank: false
              optional :contentId, type: String, allow_blank: false
              optional :episodeId, type: String, allow_blank: false
            end
    
            post do
              begin
                # user = valid_user(params['userId'].to_i, params['securityToken'])
                if true
    
                  if params[:contentId].present?
                    cast=[]
                    # director=[]
                    episode=[]
                    recommendation=[]
                    l=Content.find_by_id(params[:contentId].to_i)
                    count=l.views.to_i+1
                    l.update(views: count)
                    episodeData=l.episodes.first
                    episodeList=l.episodes
                    episodeList.each do |element|
                      episodeHash={id: element.id, name: element.title, thumbnail: element.thumbnail, runtime: element.runtime, genre: l.genre, vipStatus: element.vip_status }
                      episode << episodeHash
                    end
                    recommendationList=Content.order(views: :desc)
                    recommendationList.each do |element|
                      recommendationHash={id: element.id, thumbnail: element.banner, vipStatus: element.vip_status.present? }
                      recommendation << recommendationHash
                    end
                    detailsList = {title: l.title, episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: l.genre, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: episodeData.cast, directors: episodeData.director}
                    {
                      message: "MSG_SUCCESS", 
                      status: 200, 
                      videoDetails: detailsList,
                      episodeList: episode,
                      recommendationList: recommendation
                    }
                  else
                    episodeData=Episode.find_by_id(params[:episodeId].to_i)
                        l=episodeData.content
                        count=l.views.to_i+1
                        l.update(views: count)
                        detailsList = {title: l.title, episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: genreList, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: cast, directors: director}
                    {
                      message: "MSG_SUCCESS", 
                      status: 200, 
                      videoDetails: detailsList
                    }
                  end
                else
                  {message: "INVALID_USER", status: 500}
                end  
    
              rescue Exception => e
                logger.info "API Exception-#{Time.now}-detailPage-#{params.inspect}-Error-#{e}"
                {message: "MSG_ERROR", status: 500}
              end
            end
          end

    end
  end
end