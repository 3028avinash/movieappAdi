json.extract! coupon, :id, :code, :offer, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
