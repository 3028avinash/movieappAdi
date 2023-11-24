json.extract! content, :id, :title, :release_date, :genre, :category, :banner, :trailer_link, :vip_status, :status, :views, :created_at, :updated_at
json.url content_url(content, format: :json)
