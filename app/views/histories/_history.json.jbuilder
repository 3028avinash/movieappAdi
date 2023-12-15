json.extract! history, :id, :user_id, :episode_id, :watch_list, :favorite_list, :created_at, :updated_at
json.url history_url(history, format: :json)
