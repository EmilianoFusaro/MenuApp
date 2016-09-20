json.array!(@receives) do |receife|
  json.extract! receife, :id, :tipo, :email, :nome, :oggetto, :messaggio
  json.url receife_url(receife, format: :json)
end
