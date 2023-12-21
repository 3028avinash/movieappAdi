json.extract! help_desk, :id, :question, :answer, :url, :created_at, :updated_at
json.url help_desk_url(help_desk, format: :json)
