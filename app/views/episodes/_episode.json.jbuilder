json.extract! episode, :id, :content_id, :season, :url, :thumbnail, :title, :runtime, :cast, :director, :story, :vip_status, :status, :created_at, :updated_at
json.url episode_url(episode, format: :json)
