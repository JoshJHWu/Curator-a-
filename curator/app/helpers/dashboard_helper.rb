require 'net/http'
require 'open-uri'
require 'json'

module DashboardHelper
  def parse_posts(array)
    # for each post, makes a call to the URL/.json
    # for each post, parses the JSON data to get only the comments
    # aggregates all comments in variable
    # must return text in this form: {:text=>'text'}
  end

  def call_to_Reddit(term)
    link_array = []

    # using search term, makes a call to 2 news subreddits/hot/.json
    # selects top 5 posts from each subreddit
    world_news = URI.parse("https://www.reddit.com/r/worldnews/search.json?q=#{term}&restrict_sr=on&sort=relevance&limit=5")
    world_news_response = JSON.parse((Net::HTTP.get_response(world_news)).body)
    world_news_response["data"]["children"].each do |post|
      # for each post, keeps only URL to the post page
      link_array << "https://www.reddit.com#{post["data"]["permalink"]}"
    end

    usa_news = URI.parse("https://www.reddit.com/r/news/search.json?q=#{term}&restrict_sr=on&sort=relevance&limit=5")
    usa_news_response = JSON.parse((Net::HTTP.get_response(usa_news)).body)
    usa_news_response["data"]["children"].each do |post|
      # for each post, keeps only URL to the post page
      link_array << "https://www.reddit.com#{post["data"]["permalink"]}"
    end

    parse_posts(link_array)
  end

  def call_to_News(term)
    # makes call to news API

    # must return text in this form: {:text=>'text'}
  end

  def call_to_HPE(data)
    json_data = {}
    client = HODClient.new(ENV["HPE_KEY"])

    # analyzing content
    request = client.post('extractconcepts', data)
    json_data["concepts"] = request.json

    # analyzing sentiments
    # request = client.post('analyzesentiment', {:text=>'I like cats'})
    # json_data["sentiments"] = request.json


    # this is where we need to explore what data we get back
    # and how we want to alter it for our frontend
  end
end
