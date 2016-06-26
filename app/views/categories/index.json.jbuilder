json.array!(@categories) do |category|
  json.extract! category, :id, :titolo, :descrizione, :foto, :user_id
  json.url category_url(category, format: :json)
end
