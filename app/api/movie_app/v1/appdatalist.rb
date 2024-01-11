module MovieApp
  module V1
    class Appdatalist < Grape::API
      include MovieApp::V1::Defaults

      resource :searchContent do
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
              	content_data = []
              	if params[:searchTxt].present?              	  
              	  contents = Content.search(params[:searchTxt])
              	  if contents.present?
              	  	contents.each do |item|
              	  	  if !item.title.blank?
              	  	  showHash = {id: item.id, banner: item.banner, contentName: item.title,
              	  	   episodeName: item.title, duration: '120 min'}
                      content_data << showHash
                      end
              	  	end
              	  end
              	  episodes = Episode.search(params[:searchTxt])
              	  if episodes.present?
              	  	episodes.each do |item|
              	  	  if !item.title.blank?	
              	  	  showHash = {id: item.id, banner: item.thumbnail, contentName: item.title,
              	  	   episodeName: item.title, duration: item.runtime}
                      content_data << showHash
                      end
              	  	end
              	  end
              	  {message: MSG_SUCCESS, status: 200, showList: content_data}
              	else
              	  contents = Content.all.sample(10)
              	  contents.each do |item|
              	  	if !item.title.blank?
              	  	showHash = {id: item.id, banner: item.banner, contentName: item.title,
              	  	  episodeName: item.title, duration: '60 min'}
                    content_data << showHash
                    end
              	  end
                  color = ['#ff7f50','#87cefa','#da70d6','#32cd32','#6495ed','#ff69b4','#ba55d3','#cd5c5c','#ffa500','#40e0d0']

                  genre_set = Set.new
                  genre_list = []

                  Content.all.each do |content|
                    content.genre.split(',').each do |one|
                      genre_name = one.strip
                      next if genre_set.include?(genre_name)
                      genre_set << genre_name
                      genre_list << {
                        genreName: genre_name,
                        firstColor: color.sample,
                        secondColor: color.sample,
                      }
                    end
                  end
                  {message: MSG_SUCCESS, status: 200, showList: content_data, genreList: genre_list}
              	end                
              else
                {message: "INVALID_USER", status: 500}
              end  
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-searchContent-#{params.inspect}-Error-#{e}"
              {message: "MSG_ERROR", status: 500}
            end
          end
      end

    end
  end
end