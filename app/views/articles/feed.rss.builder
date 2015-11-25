xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'iOSonRails'
    xml.description 'iOSonRails is all about learning new technologies (iOS, Android, Ruby on Rails, React, Angular, etc) freelance and entrepreneurship'
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