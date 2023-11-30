json.extract! subscription, :id, :name, :amount, :duration, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
