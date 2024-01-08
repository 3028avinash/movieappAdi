json.extract! favorite_list, :id, :user_id, :episode_id, :created_at, :updated_at
json.url favorite_list_url(favorite_list, format: :json)
