json.extract! coupon, :id, :code, :offer, :status, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
