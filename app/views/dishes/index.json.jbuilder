json.array!(@dishes) do |dish|
  json.extract! dish, :id, :nome, :descrizione, :lista_ingredienti, :img, :img1, :img2, :img3, :user_id
  json.url dish_url(dish, format: :json)
end
