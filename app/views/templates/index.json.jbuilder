json.array!(@templates) do |template|
  json.extract! template, :id, :nome, :descrizione, :img, :ordine, :variabile_a, :variabile_b
  json.url template_url(template, format: :json)
end
