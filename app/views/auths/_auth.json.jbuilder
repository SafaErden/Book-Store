json.extract! auth, :id, :created_at, :updated_at
json.url auth_url(auth, format: :json)
