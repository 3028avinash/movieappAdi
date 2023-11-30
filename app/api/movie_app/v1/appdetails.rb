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

        end
    end
end