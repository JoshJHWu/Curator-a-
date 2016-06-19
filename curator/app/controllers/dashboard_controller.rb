class DashboardController < ApplicationController
  def index
    # render erb
  end

  def search
    # takes the param - search term
    @term = params[:term]
    # makes a call to the Reddit API
    reddit_data = call_to_Reddit(@term)
    reddit_data = call_to_HPE(reddit_data)

    # makes a call to the NYTimes API
    news_data = call_to_News(@term)
    news_data = call_to_HPE(news_data)

    # return what we got in a json to the frontend
    redirect_to json_path(term: @term)
  end

  def json
    @term = params[:term]
    news = call_to_News(@term)
    reddit = call_to_Reddit(@term)
    render json: {news: news, reddit: reddit}.to_json, layout: false
  end
end
