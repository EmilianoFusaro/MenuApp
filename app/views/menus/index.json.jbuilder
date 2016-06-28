json.array!(@menus) do |menu|
  json.extract! menu, :id, :nome, :descrizione, :categorie, :piatti, :user_id
  json.url menu_url(menu, format: :json)
end
