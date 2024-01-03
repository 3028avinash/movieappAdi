json.extract! payement_detail, :id, :user_id, :subscription_id, :order_id, :payement_id, :amount, :created_at, :updated_at
json.url payement_detail_url(payement_detail, format: :json)
