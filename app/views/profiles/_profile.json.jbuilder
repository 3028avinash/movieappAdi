json.extract! profile, :id, :user_id, :name, :age, :gender, :mobile, :created_at, :updated_at
json.url profile_url(profile, format: :json)
