require 'URI'
require 'net/http'
require 'json'

module DashboardHelper
  def call_to_Reddit(term)
    # using search term, makes a call to 3 news subreddits/hot/.json
    # selects top 5 posts from each subreddit
    # for each post, keeps only URL to the post page
    # for each post, makes a call to the URL/.json
    # for each post, parses the JSON data to get only the comments
    # aggregates all comments in variable
    # must return text in this form: {:text=>'text'}
  end

    def call_to_News(term)
    # makes call to news API
    uri = URI("https://api.nytimes.com/svc/search/v2/articlesearch.json")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    uri.query = URI.encode_www_form({
     "api-key" => "671f68145f854934b4e193b4f17434e2",
      "q" => term
    })
    request = Net::HTTP::Get.new(uri.request_uri)
    puts request.class
    @result = JSON.parse(http.request(request).body)

    # @urls= []
    # @result["response"]["docs"].each do |doc|
    #     @urls << doc["web_url"]
    # end
    # @urls
    # must return text in this form: {:text=>'text'}
  end

   

  def call_to_HPE(data)
    json_data = {}
    client = HODClient.new(ENV["HPE_KEY"])

    # analyzing content
    request = client.post('extractconcepts', data)
    json_data["concepts"] = JSON.parse(request)

    # analyzing sentiments
    # request = client.post('analyzesentiment', {:text=>'I like cats'})
    # json_data["sentiments"] = JSON.parse(request)


    # this is where we need to explore what data we get back
    # and how we want to alter it for our frontend
  end
end
