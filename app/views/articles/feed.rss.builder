xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Consigliere"
    xml.description "A blog about freelance, entrepreneurship, iOS and Ruby on Rails development"
    xml.link articles_url

    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.preview
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end