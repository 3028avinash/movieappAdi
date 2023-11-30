module MovieApp
    module V1
        class Appdetails < Grape::API
        include MovieApp::V1::Defaults

            resource :homePage do
                desc "Shows List on Home API"
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
                            bannerImage = Content.where(is_slider: true).first.banner
                            showList1=[]
                            shows= Content.where("genre LIKE ?" , "%drama%")
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList1 << showHash
                            end
                            showList2=[]
                            shows= Content.where("genre LIKE ?" , "%action%")
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList2 << showHash
                            end
                        {message: "MSG_SUCCESS", status: 200, bannerImage: bannerImage, showList1: showList1 , showList2: showList2}
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
                desc "Shows List on Home API"
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
                            showList1=[]
                            shows= Content.where("genre like ? and vip_status like ?" , "%drama%", true).limit(6)
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList1 << showHash
                            end
                            showList2=[]
                            shows= Content.where("genre like ? and vip_status like ?" , "%action%", true).limit(6)
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList2 << showHash
                            end
                            showList3=[]
                            shows= Content.where("genre like ? and vip_status like ?" , "%thriller%", true).limit(6)
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList3 << showHash
                            end
                            showList4=[]
                            shows= Content.where("genre like ? and vip_status like ?" , "%crime%", true).limit(6)
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner}
                                showList4 << showHash
                            end
                        {message: "MSG_SUCCESS", status: 200, showList1: showList1 , showList2: showList2, showList3: showList3, showList4: showList4}
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
                desc "Shows List on Home API"
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
                            showList=[]
                            shows= Content.where("release_date > ?" , Time.now.year).limit(6)
                            shows.each do |item|
                                showHash = {id: item.id, banner: item.banner, name: item.title, genre: item.genre}
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

            resource :subscriptionList do
                desc "Match List on Home API"
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
                      l=Subscription.all
                      l.each_with_index do |element,index|
                        subscriptionList[index]={id: element.id,name: element.name, duration: "For #{element.duration}", realAmount: "₹#{element.real_amount}/-", offerAmount: "₹#{element.real_amount}/-"}
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
                  requires :isEpisode, type: String, allow_blank: false
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
        
                        episodeData=Episode.where(content_id: l.id).first
        
                        castList=episodeData.cast
                        directorList=episodeData.director
        
                        episodeList=Episode.where(content_id: params[:contentId].to_i)
        
                        episodeList.each do |element|
                          episodeHash={id: element.id, name: element.title, thumbnail: element.thumbnail, runtime: element.runtime, genre: l.genre, vipStatus: element.vip_status }
                          episode << episodeHash
                        end
        
                        recommendationList=Content.order(views: :desc)
                        recommendationList.each do |element|
                          recommendationHash={id: element.id, thumbnail: element.banner, vipStatus: element.vip_status.present? }
                          recommendation << recommendationHash
                        end
                        detailsList = {title: l.title, episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: l.genre, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList:l.cast, directors: l.director}
                        {
                          message: "MSG_SUCCESS", 
                          status: 200, 
                          videoDetails: detailsList,
                          episodeList: episode,
                          recommendationList: recommendation
                        }
        
                      else
        
                        if episodeList == false
                          cast=[]
                          # director=[]
                          episode=[]
                          recommendation=[]
                          episodeData=Episode.find_by_id(params[:episodeId].to_i)
                          l=Content.find_by_id(episodeData.content_id)
                          count=l.views.to_i+1
                          l.update(views: count)
                          detailsList = {title: l.title, episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: l.genre, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: l.cast, directors: l.director}
                          {
                            message: "MSG_SUCCESS", 
                            status: 200, 
                            videoDetails: detailsList
                          }
                        else
                          cast=[]
                          # director=[]
                          episode=[]
                          recommendation=[]
                          episodeData=Episode.find_by_id(params[:episodeId].to_i)
        
                              castList=episodeData.cast_id
                              directorList=episodeData.director_id
                              
                              # wh=Watchhistory.find_by(episode_id: params[:episodeId].to_i)
        
                              l=Content.find_by_id(episodeData.content_id)
        
                              count=l.views.to_i+1
                              l.update(views: count)
                              
                              # if !wh.present?
                              #   Watchhistory.create(user_id: params[:userId].to_i,content_id: l.id,episode_id: params[:episodeId].to_i)
                              # else
                              #   wh.touch
                              # end
        
                              # episodeList
                              episodeList=Episode.where(content_id: l.id)
                              episodeList.each do |element|
                                episodeHash={id: element.id, name: element.title, thumbnail: element.thumbnail, runtime: element.runtime, vipStatus: element.vip_status }
                                episode << episodeHash
                              end
        
                              recommendationList=Content.where(genre: l.genre)
                              recommendationList.each do |element|
                                recommendationHash={id: element.id, thumbnail: element.banner, vipStatus: element.vip_status.present? }
                                recommendation << recommendationHash
                              end
        
                              castList=castList.split(",")
                              castList.each do |item|
                                k= Cast.find_by_id(item.to_i)
                                castHash = {id: k.id, name: k.name, image_url: k.image}
                                cast << castHash
                              end
        
                              director=""
                              directorList=directorList.split(",")
                              directorList.each_with_index do |item, index|
                                k = Director.find_by_id(item.to_i)
                                director << k.name
                                director << "," unless index == directorList.length - 1  # Add '/' except for the last item
                              end
        
        
                              genreList=""
                              genre = l.genre.split(",")
                              genre.each_with_index do |item, index|
                                genreList << item
                                genreList << "/" unless index == directorList.length - 1
                              end
        
                              isFav=false
                              isWL=false
                              hisList=History.find_by_user_id(params[:userId].to_i)
                              if hisList
                                fList=hisList.favorite_list
                                wList=hisList.watch_list
        
                                fList=fList.split(",")
                                if fList.include?(episodeData.id.to_s)
                                  isFav=true
                                else
                                  isFav=false
                                end
        
                                wList=wList.split(",")
                                if wList.include?(episodeData.id.to_s)
                                  isWL=true
                                else
                                  isWL=false
                                end
                              end
        
                              wh=Watchhistory.find_by("user_id = ? and episode_id = ?",params[:userId].to_i, episodeData.id)
        
                              detailsList = {favList: isFav, watchList: isWL, title: l.title, episodeId: episodeData.id, episodeName: episodeData.title, year: l.release_date, trailerLink: l.trailer_link, genre: genreList, story: episodeData.story, url: episodeData.url, runtime: episodeData.runtime, castList: cast, directors: director, startTime: wh.present? ? wh.duration : 0}
                          {
                            message: "MSG_SUCCESS", 
                            status: 200, 
                            videoDetails: detailsList,
                            episodeList: episode,
                            recommendationList: recommendation
                          }
                        end
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