json.extract! subscription, :id, :name, :real_amount, :offer_amount, :duration, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
