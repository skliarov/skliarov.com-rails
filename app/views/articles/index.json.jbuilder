json.array!(@articles) do |article|
  json.extract! article, :title, :body, :published
  json.url article_url(article, format: :json)
end
