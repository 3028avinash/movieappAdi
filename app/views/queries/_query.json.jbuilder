json.extract! query, :id, :user_id, :query_type, :message, :created_at, :updated_at
json.url query_url(query, format: :json)
