json.array!(@decks) do |deck|
  json.extract! deck, :id, :name, :description, :public, :active
  json.url deck_url(deck, format: :json)
end
