class Rack::Attack
  blacklist("block referer spam") do |request|
    spammers = [
      /pornhub-forum\.uni\.me/,
      /free-share-buttons\.com/,
      /best-seo-offer\.com/,
      /buttons-for-your-website\.com/,
      /darodar\.com/,
      /Get-Free-Traffic-Now\.com/,
      /theguardlan\.com/,
      /best-seo-offer\.com/,
      /free-social-buttons\.com/,
      /event-tracking\.com/
    ]
    spammers.find { |spammer| request.referer =~ spammer }
  end
end
