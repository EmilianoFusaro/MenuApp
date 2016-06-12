json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :nome, :descrizione, :img, :img1, :img2, :allergen_id
  json.url ingredient_url(ingredient, format: :json)
end
