json.extract! subscription_history, :id, :user_id, :subscription_id, :subscription_start, :subscription_end, :coupon_id, :created_at, :updated_at
json.url subscription_history_url(subscription_history, format: :json)
