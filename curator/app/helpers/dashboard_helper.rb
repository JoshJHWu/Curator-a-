require 'net/http'
require 'open-uri'
require 'json'

module DashboardHelper
  def recursive_comment_digging(child, comments="")
    comments << " #{child["body"]} "
    if child["replies"].nil? || child["replies"].empty?
      return comments
    else
      child["replies"]["data"]["children"].each do |comment|
        comments << " #{recursive_comment_digging(comment["data"])} "
      end
      return comments
    end
  end

  def parse_posts(array)
    json = {text:"", posts: []}

    # for each post, makes a call to the URL/.json
    array.each_with_index do |post, i|
      url = post.dup
      id = i + 1

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.initialize_http_header({"User-Agent" => "Curator_v0.1_mindplace"})
      body = http.request(request)
      body = JSON.parse(body.body)

      # for each post, parses the JSON data to get only the comments
      comments = ""
      body[1]["data"]["children"].each do |child|
        comments << " #{recursive_comment_digging(child["data"])} "
      end

      title = body[0]["data"]["children"][0]["data"]["title"]
      post = {id: id, title: title, url: url[0..-6]}

      json[:text] << comments
      json[:posts] << post
    end

    json
  end

  def call_to_Reddit(term)
    link_array = []

    ["worldnews", "news"].each do |subreddit|
      news = URI.parse("https://www.reddit.com/r/#{subreddit}/search.json?q=#{term}&restrict_sr=on&sort=relevance&limit=1")
      http = Net::HTTP.new(news.host)
      request = Net::HTTP::Get.new(news.request_uri)
      request.initialize_http_header({"User-Agent" => "Curator_v0.1_mindplace"})
      body = http.request(request)
      news_response = JSON.parse(body.body)
      link_array << "https://www.reddit.com#{news_response["data"]["children"][0]["data"]["permalink"][0..-18]}.json"
    end

    parse_posts(link_array)
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
    result = JSON.parse(http.request(request).body)
    results = result["response"]["docs"]
    json = {text:"", posts: []}

    results.each_with_index do |article, i|
      id = i + 1
      headline = article["headline"]["main"]
      json[:text] << " #{article["snippet"]} #{article["lead_paragraph"]} #{article["abstract"]}"
      post = {id: id, title: headline, url: article["web_url"]}
      json[:posts] << post
    end

    json
  end
end
