class DashboardController < ApplicationController
  def index
    # render erb
  end

  def initialize
    # takes the param - search term
    term = params[:term]

    # makes a call to the Reddit API
    reddit_data = call_to_Reddit(term)
    reddit_data = call_to_HPE(reddit_data)

    # makes a call to the NYTimes API
    news_data = call_to_News(term)
    news_data = call_to_HPE(news_data)

    # return what we got in a json
  end
end
