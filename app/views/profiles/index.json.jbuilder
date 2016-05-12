json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :tipo, :descrizione
  json.url profile_url(profile, format: :json)
end
