json.array!(@allergens) do |allergen|
  json.extract! allergen, :id, :nome, :descrizione, :img, :img1, :img2
  json.url allergen_url(allergen, format: :json)
end
